Rails.application.routes.draw do
  scope '/v1', defaults: { format: 'json' } do
    root 'sites#index'
    resources :sites, only: [:index, :create]
  end
end
