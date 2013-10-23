class User
  attr_reader :id
  def initialize id
    @id = id
  end
  def self.new id
    return NullUser.new unless id
    super id
  end
  def equipment
    @equipment ||= Item.where(:user => @id)
  end

  def admin?
    HeliCat::Application.config.admins.include? @id
  end

  class NotAuthorized < StandardError
    def initialize(msg = "User not authorized to view this resource.")
      super(msg)
    end
  end
end
class NullUser
  def id; nil; end
  def equipment; []; end
  def admin?; false; end
end