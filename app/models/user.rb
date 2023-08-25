class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bikes, dependent: :destroy
  has_many :rentals, dependent: :destroy
  has_one_attached :profile_picture

  validates   :last_name,
              presence: true,
              format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates   :first_name,
              presence: true,
              format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :email, presence: true, uniqueness: true
end
