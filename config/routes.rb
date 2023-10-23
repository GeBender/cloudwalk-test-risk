Rails.application.routes.draw do
  post '/transactions/validate', to: 'transactions#validate'
end
