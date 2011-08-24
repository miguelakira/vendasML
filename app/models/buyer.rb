class Buyer < ActiveRecord::Base
	validates :name, :presence => true
	validates :nickname, :presence => true
	validates :sale_id, :presence => true
	validates :city, :presence => true
	validates :state, :presence => true
	
	belongs_to :sale
    accepts_nested_attributes_for :sale
end

  