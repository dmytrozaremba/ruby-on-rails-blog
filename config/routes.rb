Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/articles')

  resources :articles do
    resources :comments
  end
end
