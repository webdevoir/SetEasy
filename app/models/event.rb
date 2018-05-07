class Event < ApplicationRecord
	has_and_belongs_to_many :crews
	belongs_to :location, optional: true
	validates :title, presence: true
	attr_accessor :date_range
end
