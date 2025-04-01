class HeaderComponent < ViewComponent::Base
    def initialize(current_user:)
      @current_user = current_user
      @current_account = Current.account
    end

    private

    attr_reader :current_user, :current_account
end
