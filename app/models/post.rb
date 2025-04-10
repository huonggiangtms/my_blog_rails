class Post < ApplicationRecord
    attribute :published, :boolean, default: true

    belongs_to :user
    belongs_to :category

    validates :title, presence: true, length: { minimum: 5, maximum: 100 }
    validates :content, presence: true

    scope :published, -> { where(published: true) }
end