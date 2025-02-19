class ApplicationController < ActionController::Base
  include Authentication
  include Components
  before_action :set_current_account

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_current_account
    Current.account ||= current_user&.account
  end
end
