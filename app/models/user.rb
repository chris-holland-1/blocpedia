class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :email, :password, :password_confirmation, :remember_me

  has_many :wikis
  # has_one :address
  # after_initialize :init

  #def init
    #self.number  ||= 0.0           #will set the default value only if it's nil
    #self.address ||= build_address #let's you set a default association
  #end

  before_save { self.email = email.downcase if email.present? }
  # before_save { self.role ||= :standard }

  after_initialize { self.role ||= :standard }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "encrypted_password.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

  enum role: [:standard, :premium, :admin]
end
