Rails.application.routes.draw do
  devise_for :users
  root to: 'application#index'
  post '/import' => 'xml_import#import', as: 'xml_upload'
  get '/process_import' => 'xml_import#index', as: 'xml_process'
  get '/select_teacher' => 'application#select_teacher', as: 'select_teacher'
  post '/select_teacher/:id' => 'application#assign_teacher', as: 'assign_teacher'
end
