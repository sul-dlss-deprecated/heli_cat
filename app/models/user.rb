class User
  attr_reader :id
  def initialize(id)
    @id = id
  end
  def computers
    @computers ||= Item.where(:user => @id)
  end
end