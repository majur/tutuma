class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_current_account
  helper_method :current_account

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def current_account
    Current.account
  end

  def set_current_account
    # Ak už je nastavený aktuálny tenant, použije sa
    return if Current.account.present?
    
    # Ak je používateľ prihlásený a má len jeden tenant, použije sa ten
    if current_user && current_user.accounts.count == 1
      Current.account = current_user.accounts.first
      return
    end
    
    # Ak je používateľ prihlásený a má v session nastavený tenant_id, použije sa ten (ak má k nemu prístup)
    if current_user && session[:current_account_id].present?
      selected_account = current_user.accounts.find_by(id: session[:current_account_id])
      if selected_account.present?
        Current.account = selected_account
        return
      else
        session.delete(:current_account_id)
      end
    end
    
    # Ak je používateľ prihlásený a má viac tenantov, použije sa prvý
    if current_user && current_user.accounts.any?
      Current.account = current_user.accounts.first
    end
  end
  
  def ensure_admin
    redirect_to root_path, alert: "Nemáte oprávnenie pre túto akciu" unless current_user.admin_in?(current_account)
  end
end
