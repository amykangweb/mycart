class Order < ActiveRecord::Base
	validates :address, :city, :state, presence: true
	belongs_to :listing
	belongs_to :seller, class_name: "User"
	belongs_to :buyer, class_name: "User"
	default_scope -> {order('created_at DESC')}

	self.per_page = 10
end
