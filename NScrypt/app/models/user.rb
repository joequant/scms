class User < ActiveRecord::Base
  has_many :parties
  #attr_accessible :email, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  # type is the default column for STI. Uncomment this and change to other column if necessary
  #self.inheritance_column = :type

  # We will need a way to know which types
  # will subclass the User model
  def self.types
    %w(Person Corporation)
  end


  scope :people, -> { where(type: 'Person') }
  scope :corporations, -> { where(type: 'Corporation') }

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  #Test polymorphism
  def greet
    "I'm an abstract user"
  end
end
