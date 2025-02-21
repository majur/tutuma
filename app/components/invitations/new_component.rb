module Components
  module Invitations
    class NewComponent < Components::Base
      include Phlex::Rails::Helpers::FormWith
      include Phlex::Rails::Helpers::FieldsFor
      include Phlex::Rails::Helpers::FormTag

      def view_template
        h1 { "Invite Team Members" }

        form action: invitations_path, method: :post, data: { controller: "invitations" } do
          div id: "invitation-fields" do
            div class: "invitation-row mb-4 p-4 border rounded" do
              fields_for "invitations[]", Invitation.new do |f|
                div class: "mb-2" do
                  label for: "invitations__name", class: "block text-sm font-medium text-gray-700" do
                    plain "Name"
                  end
                  input type: "text", 
                       name: "invitations[][name]", 
                       id: "invitations__name",
                       required: true,
                       class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                end

                div class: "mb-2" do
                  label for: "invitations__email", class: "block text-sm font-medium text-gray-700" do
                    plain "Email"
                  end
                  input type: "email",
                       name: "invitations[][email]",
                       id: "invitations__email",
                       required: true,
                       class: "mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"
                end
              end
            end
          end

          div class: "mt-4 space-x-4" do
            button type: "button",
                   data_action: "click->invitations#addRow",
                   class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" do
              plain "Add Another Person"
            end

            button type: "submit",
                   class: "bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" do
              plain "Send Invitations"
            end
          end
        end
      end
    end
  end
end 