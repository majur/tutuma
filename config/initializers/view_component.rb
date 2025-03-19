# frozen_string_literal: true

Rails.application.configure do
  config.view_component.preview_paths << Rails.root.join("spec/components/previews") if Rails.env.development?
end 