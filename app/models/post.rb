class PostValidator < ActiveModel::Validator
    def validate(record)
      unless !record.title || record.title.match(/Won[']t Believe | Top \d | Guess /) != nil
        record.errors[:title] << 'Need to contain "Won\'t Believe", "Top [number]" or "Guess"!'
      end
    end
end

class Post < ActiveRecord::Base
  include ActiveModel::Validations
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validates_with PostValidator
end
