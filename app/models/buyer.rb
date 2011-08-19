class Buyer < ActiveRecord::Base
	validates :name, :nickname, :email, :sale_id, :city, :state, :presence => true
	belongs_to :sale
    accepts_nested_attributes_for :sale
end

  