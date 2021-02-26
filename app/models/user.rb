# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  VALID_USERNAME = /\A[a-zA-Z0-9]+\Z/
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 25 },
                       format: { with: VALID_USERNAME }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :about, presence: true,
                    length: { maximum: 150 }
  has_secure_password
end
