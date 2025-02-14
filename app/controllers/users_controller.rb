class UsersController < ApplicationController
    def index
      @users = current_user.account.users
      @account = current_user.account
    end
end
