class Sale < ActiveRecord::Base
	validates :title, :price, :tax, :cost, :presence => true
	
end
