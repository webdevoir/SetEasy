class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  before_validation :set_user_id, if: :email?
  
  attribute :email, :string

  def set_user_id
	  existing_user = User.find_by(email: email)
	  self.user = if existing_user.present?
	                existing_user
	              else
	                User.invite!(email: email)
	              end
	end
end
