class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :omniauthable 
  devise :database_authenticatable, :recoverable, :rememberable, :registerable, :confirmable,
    :trackable, :validatable
  has_many :parties

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  # type is the default column for STI. Uncomment this and change to other column if necessary
  #self.inheritance_column = :type

  def admin?
    self.role == 'admin'
  end

end
