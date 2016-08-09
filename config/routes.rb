Rails.application.routes.draw do
  root to: redirect('/v1/sites')

  scope '/v1', defaults: { format: 'json' } do
    resources :sites, only: [:index, :create]
  end
end
