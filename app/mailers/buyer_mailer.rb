class BuyerMailer < ActionMailer::Base
  default :from => "miguel.akira@gmail.com"

  def nova_compra(buyer)
    @buyer = buyer
    @site = "http://bit.ly/PS3Vendas"
    mail(:to => "#{buyer.name} <#{buyer.email}>", 
        :cco => "miguel.akira@gmail.com",
        :subject => "(Jogo) #{buyer.sale.title}"
        )
  end

  def pagamento_confirmado(buyer)
    @buyer = buyer
    @site = "http://bit.ly/PS3Vendas"
    mail(:to => "#{buyer.name} <#{buyer.email}>", 
        :cco => "miguel.akira@gmail.com",
        :subject => "(Jogo) #{buyer.sale.title} - Pagamento Confirmado!"
        )
  end

  def jogo_entregue(buyer)
    @buyer = buyer
    @site = "http://bit.ly/PS3Vendas"
    mail(:to => "#{buyer.name} <#{buyer.email}>", 
        :cco => "miguel.akira@gmail.com",
        :subject => "(Jogo) #{buyer.sale.title} - Entrega concluida"
        )
  end

  def jogo_enviado(buyer)
    @buyer = buyer
    @site = "http://bit.ly/PS3Vendas"
    mail(:to => "#{buyer.name} <#{buyer.email}>", 
        :cco => "miguel.akira@gmail.com",
        :subject => "(Jogo) #{buyer.sale.title} ENVIADO!  " 
        )
  end


end
