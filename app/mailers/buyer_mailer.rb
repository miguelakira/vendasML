class BuyerMailer < ActionMailer::Base
  default :from => "miguel.akira@gmail.com"

  def nova_compra(buyer)
    @buyer = buyer
    @site = "http://bit.ly/PS3Vendas"
    mail(:to => @buyer.email, 
        :subject => "(Jogo) " + buyer.sale.title
        )
    end

end
