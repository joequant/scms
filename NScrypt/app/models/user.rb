class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, and :registerable
  devise :database_authenticatable, :recoverable, :rememberable,
    :trackable, :validatable
  has_many :parties

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

  def admin?
    self.role == 'admin'
  end


  #Test polymorphism
  def greet
    "I'm an abstract user"
  end
end
