class UsersController < ApplicationController
    def index
      @users = current_account.users
      @account = current_account
    end
end
