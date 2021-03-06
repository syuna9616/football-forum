# == Route Map
#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#                    boards GET  /boards(.:format)                                                                        boards#index
#                 new_board GET  /boards/new(.:format)                                                                    boards#new
#                     board GET  /boards/:id(.:format)                                                                    boards#show
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users
  resources :boards, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :comments, only: [:create, :destroy]
  root 'boards#index'

  get "users/profile/:id", to: "users#profile"

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
