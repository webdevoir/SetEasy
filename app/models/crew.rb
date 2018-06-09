class Crew < ApplicationRecord
	belongs_to :project
	has_and_belongs_to_many :events

	validates_presence_of :email
	validates_presence_of :name
	validates_presence_of :availability
	validates_presence_of :role
end
