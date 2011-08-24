class BuyersController < ApplicationController
  # GET /buyers
  # GET /buyers.xml

  USERS = { 'mig_akira' => 'ar4nhas'}

  before_filter :authenticate, :only => [:new, :edit, :destroy]


  def index
    @buyers_in_progress = Buyer.find(:all, :conditions => {:sent => false, :finished => false}, :order => :created_at )
    @buyers_sent = Buyer.find(:all, :conditions => {:sent => true, :finished => false}, :order => :created_at )
    @buyers_finished = Buyer.find(:all, :conditions => {:finished => true}, :order => :created_at )
    @total_profit = 0
    unless @buyers_finished.empty?
      @buyers_finished.each do |buyer| 
        @total_profit += buyer.profit
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
    @sales = Sale.find(:all, :conditions => ["quantity > ?", 0])
    
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
        BuyerMailer.nova_compra(@buyer).deliver
        format.html { redirect_to(@buyer, :notice => 'Buyer was successfully created.') }
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

  private
  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
      
    end
  end
end
