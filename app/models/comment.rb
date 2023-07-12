class Comment < ApplicationRecord
  belongs_to :author, class_name: 'Users'
  belongs_to :post
end