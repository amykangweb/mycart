class Listing < ActiveRecord::Base
	if Rails.env.development?
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100" }, :default_url => "default.jpg"
		validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	else
		has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }, :default_url => "default.jpg", 
			:storage => :dropbox,
			:dropbox_credentials => Rails.root.join("config/dropbox.yml"), 
			:path => ":style/:id_:filename"
		validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
	end

	searchkick
	
	default_scope -> {order('created_at DESC')}
	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than: 0 }
	validates :description, presence: true, length: {maximum: 200}
	validates_attachment_presence :image

	belongs_to :user
	has_many :orders
	has_many :reviews, dependent: :destroy
end
