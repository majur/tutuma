class LogoutButtonComponent < ViewComponent::Base
    def initialize(full_width: false, css_class: nil)
      @full_width = full_width
      @css_class = css_class
    end

    private

    attr_reader :full_width, :css_class
end
