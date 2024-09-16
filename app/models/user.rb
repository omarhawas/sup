class User < ApplicationRecord
  has_secure_password

  has_many :messages
  has_many :chat_users
  has_many :chats, through: :chat_users
end
