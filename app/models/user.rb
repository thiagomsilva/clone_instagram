class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :username, presence: true
  validates :username, uniqueness: true

  # Associação do post com o usuário, mas quando um user for apagado, os posts tbm serão apagados
  has_many :posts, foreign_key: :created_by_id, dependent: :destroy
  # has_many :likes
  # has_many :comments

  # has_one_attached :avatar
  # validates :avatar, content_type: %i[png jpg jpeg]
end