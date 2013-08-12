class User
  attr_reader :id
  def initialize(id)
    @id = id
  end
  def equipment
    @equipment ||= Item.where(:user => @id)
  end

  def admin?
    HeliCat::Application.config.admins.include? @id
  end
end