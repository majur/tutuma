class AccountController < ApplicationController
  def switch
    # Zobrazenie zoznamu tenantov pre prepínanie
    @accounts = current_user.accounts
  end

  def set_current
    account_id = params[:account_id]
    account = current_user.accounts.find_by(id: account_id)

    if account.present?
      session[:current_account_id] = account.id
      Current.account = account
      redirect_to root_path, notice: "Prepnuté na tenant: #{account.name}"
    else
      redirect_to root_path, alert: "Nemáte prístup k tomuto tenantu"
    end
  end
end
