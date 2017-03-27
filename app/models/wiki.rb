class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators

  #before_create :default_role
  after_initialize :initialize_role

  private

  def initialize_role
    self.private = false if self.private.nil?
  end

  #def default_role
    #self.public = true if self.public.nil?
  #end
end
