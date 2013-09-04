module Features
  module LoginHelpers
    def login_as_admin
      ApplicationController.any_instance.stub(:current_user).and_return(admin_user)
    end

    def admin_user
      user = User.new('admin-user')
      user.stub(:admin?).and_return(true)
      user
    end

    def login_as user
      ApplicationController.any_instance.stub(:current_user).and_return(user_object_for(user))
    end

    def user_object_for user
      user = User.new(user.id)
      user.stub(:admin?).and_return(user.admin?)
    end
  end
end