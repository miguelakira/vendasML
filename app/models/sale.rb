class Sale < ActiveRecord::Base
	validates :title, :price, :tax, :cost, :presence => true
	has_many :buyers
end
