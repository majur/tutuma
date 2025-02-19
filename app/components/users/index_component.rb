module Components
  module Users
    class IndexComponent < Components::Base
      def initialize(account:, users:, current_user:)
        @account = account
        @users = users
        @current_user = current_user
      end

      def template
        div(class: "space-y-6") do
          div(class: "space-y-2") do
            h1(class: "text-2xl font-bold") { @account.name }
            h2(class: "text-xl") { "Team Members" }
          end
          
          if @current_user.admin?
            div(class: "my-4") do
              link_to "Invite Team Members", new_invitation_path, class: "button bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
            end
          end

          ul(class: "space-y-2 my-4") do
            @users.each do |user|
              li(class: "p-2 bg-gray-50 rounded") do
                text "#{user.name} (#{user.email_address})#{' (Admin)' if user.admin?}"
              end
            end
          end

          div(class: "mt-6") do
            button_to "Logout", logout_path, 
              method: :delete, 
              class: "logout-button bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
          end
        end
      end
    end
  end
end 