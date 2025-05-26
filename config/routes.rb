Rails.application.routes.draw do
  resources :puny_humen, only: [:create]
  resources :puny_human_approvals, only: [:show]

  get "hulk-have-new-email-friend", to: "static#hulk_have_new_email_friend"
  root "static#index"
end
