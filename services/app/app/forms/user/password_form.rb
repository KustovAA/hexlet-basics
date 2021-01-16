# frozen_string_literal: true

class User::PasswordForm < User
  include ActiveFormModel

  permit :password

  validates :password, presence: true, length: { minimum: 6 }
end
