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

    def login_as user, opts={}
      ApplicationController.any_instance.stub(:current_user).and_return(user_object_for(user, opts))
    end

    def user_object_for user, opts={}
      user = User.new(user)
      user.stub(:admin?).and_return(user.admin?) if opts[:admin?]
      user
    end
  end
end