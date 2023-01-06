class Post < ApplicationRecord
    validates :description, presence: true
    
    # Associação do post com o usuário
    belongs_to :created_by, class_name: "User"
  
    has_many :likes, dependent: :destroy
    # has_many :comments, dependent: :destroy
  
    # Relacionamento para upload da tabela photo criado pela gem active_storage
    has_one_attached :photo
    # Gem active_storage_validations
    validates :photo, attached: true,
      content_type: %i[png jpg jpeg],
      size: { less_than: 5.megabytes }
  
    def liked_by?(user)
      likes.where(user: user).exists?
    end
  end