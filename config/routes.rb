Rails.application.routes.draw do
  post '/titles/import', action: 'create', controller: 'titles'
  get '/titles', action: 'show', controller: 'titles'
end
