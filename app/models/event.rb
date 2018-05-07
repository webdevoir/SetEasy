class Event < ApplicationRecord
	validates :title, presence: true
	attr_accessor :date_range
end
