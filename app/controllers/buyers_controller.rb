class BuyersController < ApplicationController
  # GET /buyers
  # GET /buyers.xml

  USERS = { 'mig_akira' => 'ar4nhas'}

  
  


  def index
    if current_user
      @buyers_in_progress = Buyer.find(:all, :conditions => {:user_id => current_user.id, :sent => false, :finished => false}, :order => 'created_at DESC' )
      @buyers_sent = Buyer.find(:all, :conditions => {:user_id => current_user.id, :sent => true, :finished => false}, :order => 'created_at DESC' )
      @buyers_finished = Buyer.find(:all, :conditions => {:user_id => current_user.id, :finished => true}, :order => 'created_at DESC' )
      @total_profit = 0
      unless @buyers_finished.empty?
        @buyers_finished.each do |buyer| 
          @total_profit += buyer.profit
        end
      end
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buyers }
    end
  end

  # GET /buyers/1
  # GET /buyers/1.xml
  def show
    @buyer = Buyer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @buyer }
    end
  end

  # GET /buyers/new
  # GET /buyers/new.xml
  def new
    @buyer = Buyer.new
    @sales = Sale.find(:all, :conditions => ["quantity > ? AND user_id = ?", 0, current_user.id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @buyer }
    end
  end

  # GET /buyers/1/edit
  def edit
    @buyer = Buyer.find(params[:id])
    @sales = Sale.all
  end

  # POST /buyers
  # POST /buyers.xml
  def create
    @buyer = Buyer.new(params[:buyer])
    @buyer.profit = @buyer.sale.price - (@buyer.sale.price * @buyer.sale.tax) - @buyer.sale.cost
    @buyer.sale.quantity = @buyer.sale.quantity - 1
    respond_to do |format|
      if @buyer.save
        if params[:send_mail]
          BuyerMailer.nova_compra(@buyer).deliver
        end
        format.html { redirect_to(buyers_path, :notice => 'Buyer was successfully created.') }
        format.xml  { render :xml => @buyer, :status => :created, :location => @buyer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @buyer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buyers/1
  # PUT /buyers/1.xml
  def update
    @buyer = Buyer.find(params[:id])  
    if params[:buyer][:sent] == '1' and @buyer.sent == false
      @buyer.sent_at = Time.now
    end

    if params[:send_mail]
      if params[:buyer][:paid] == '1' and @buyer.paid == false
        envia_mail_pagamento = true
      end

      if params[:buyer][:sent] == '1' and @buyer.sent == false
        @buyer.sent_at = Time.now
        envia_mail_jogo_enviado = true
      end
    end
    
    
    respond_to do |format|
      if @buyer.update_attributes(params[:buyer])
        if envia_mail_pagamento
          BuyerMailer.pagamento_confirmado(@buyer).deliver
        end
        
        if envia_mail_jogo_enviado
          BuyerMailer.jogo_enviado(@buyer).deliver
        end
      
        format.html { redirect_to(@buyer, :notice => 'Buyer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @buyer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1
  # DELETE /buyers/1.xml
  def destroy
    @buyer = Buyer.find(params[:id])
    # ao apagar um comprador, a quantia de produtos deve aumentar em 1, já que a venda foi cancelada.
    sale = Sale.find_by_id(@buyer.sale_id)
    sale.quantity += 1
    sale.update_attributes(:quantity => sale.quantity)
    @buyer.destroy

    respond_to do |format|
      format.html { redirect_to(buyers_url) }
      format.xml  { head :ok }
    end
  end

end
