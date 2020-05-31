class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  has_many :publications
  has_many :following_users
  has_many :followings, through: :following_users
  has_one :profile
  after_create :generate_profile

  private

  def generate_profile
    Profile.create(user: self, name: '', bio: '')
  end
end
