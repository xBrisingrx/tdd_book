class User < ApplicationRecord
  validates :name,
              presence: true,
              uniqueness: true
  validates :email,
              presence: true,
              uniqueness: true,
              format: { with: /\A\S+@\S+\z/ }
end
