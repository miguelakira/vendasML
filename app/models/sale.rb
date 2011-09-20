class Sale < ActiveRecord::Base
	validates :title, :price, :tax, :cost, :presence => true
	
	belongs_to :user
end
