class TeamMembersComponent < ViewComponent::Base
    def initialize(account:, users:, current_user:)
      @account = account
      @users = users
      @current_user = current_user
    end

    private

    attr_reader :account, :users, :current_user
end
