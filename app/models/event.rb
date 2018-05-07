class Event < ApplicationRecord
	has_and_belongs_to_many :crews
	validates :title, presence: true
	attr_accessor :date_range
end
