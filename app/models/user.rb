class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: { message: 'must be present' }, uniqueness: { message: 'is not unique. Please choose another one', case_sensitive: false, unless: lambda { |user| user.email.nil? or user.email.blank? }},
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'not valid' }

  validates :first_name, :last_name, :date_of_birth, presence: { message: 'must be present'}

end
