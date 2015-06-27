class Trip < ActiveRecord::Base
	
  has_many :locations
  belongs_to :user
  has_one :origin, class_name: "Location", foreign_key: "origin_id"
  has_one :destination, class_name: "Location", foreign_key: "dest_id"

end
