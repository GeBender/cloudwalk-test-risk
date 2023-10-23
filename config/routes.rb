Rails.application.routes.draw do
  resources :transactions, only: [:create]
  post '/transactions/validate', to: 'transactions#validate'
  post '/transactions/set-chargeback', to: 'transactions#set_chargeback'
end
