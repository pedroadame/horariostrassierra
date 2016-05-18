Rails.application.routes.draw do
  root 'application#index'
  post '/import' => 'xml_import#import', as: 'xml_upload'
  get '/process_import' => 'xml_import#index', as: 'xml_process'
end
