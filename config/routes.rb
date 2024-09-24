Rails.application.routes.draw do
  get "pages/show"
  get'page/:slug',
    to: 'pages#show',
    slug: /[-a-z0-9+]*/,
    as: :page

  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # Defines the root path route ("/")
  root "home#index"
end
