class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_many :projects, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users


  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    after_create :send_admin_mail

	  def send_admin_mail
	    MainMailer.send_new_user_message(self).deliver
	  end
end
