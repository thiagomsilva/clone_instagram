class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  # Para renderizar o comentário de forma correta.
  has_rich_text :body
end
