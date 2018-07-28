class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # has_many :projects, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users, dependent: :destroy 


  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
