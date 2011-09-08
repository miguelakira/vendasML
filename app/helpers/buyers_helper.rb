module BuyersHelper

	def view_tracking(code)
		url = "http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=#{ code }"
		link_to code, url, :target => '_blank'
	end


end
