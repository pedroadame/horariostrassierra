Rails.application.routes.draw do
  scope "(:locale)", locale: /es|en/ do
    devise_for :users
    get '/import' => 'xml_import#index', as: 'new_database'
    post '/import' => 'xml_import#import', as: 'xml_upload'
    get '/process_import' => 'xml_import#index', as: 'xml_process'
    get '/select_teacher' => 'application#select_teacher', as: 'select_teacher'
    post '/select_teacher/:id' => 'application#assign_teacher', as: 'assign_teacher'
    root to: 'application#index'
  end

  get '/:locale' => 'application#index'
end
