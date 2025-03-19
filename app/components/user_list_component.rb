# frozen_string_literal: true

class UserListComponent < ApplicationComponent
  def initialize(users:)
    @users = users
  end
end 