class User
  attr_reader :id
  def initialize(id)
    @id = id
  end
  def equipment
    @equipment ||= Item.where(:user => @id)
  end
end