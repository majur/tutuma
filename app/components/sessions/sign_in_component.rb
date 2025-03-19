module Sessions
  class SignInComponent < ViewComponent::Base
    def initialize(flash: {}, params: {})
      @flash = flash
      @params = params
    end
  end
end 