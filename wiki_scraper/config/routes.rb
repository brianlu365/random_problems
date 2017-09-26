Rails.application.routes.draw do

  root 'pages#home' # this is the entry point for the UI

  namespace :api do
    # API controller goes here
    get '/event-summary', to: 'events#event_summary'
    get '/event-dates', to: 'events#event_dates'
    get '/check-jobs', to: 'events#check_jobs'
  end
end
