class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :fields
         has_many :field_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :group_customers, dependent: :destroy
         
end
