Rails.application.routes.draw do
  root to: redirect('/articles')

  get '/articles', to: 'articles#index'
end
