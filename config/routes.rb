Rails.application.routes.draw do
  scope "(:locale)", locale: /es|en/ do
    devise_for :users
    get '/admin_panel' => 'xml_import#index', as: 'admin_panel'
    post '/import' => 'xml_import#import', as: 'xml_upload'
    get '/process_import' => 'xml_import#index', as: 'xml_process'
    get '/select_teacher' => 'application#select_teacher', as: 'select_teacher'
    post '/select_teacher/:id' => 'application#assign_teacher', as: 'assign_teacher'
    get '/guards' => 'teachers#guards', as: 'profs_guardia'
    get '/teachers/:id' => 'teachers#schedule', as: 'teacher_schedule'
    get '/teachers' => 'teachers#teachers', as: 'teacher_list'
    get '/empty_rooms' => 'rooms#empties', as: 'aulas_vacias'
    get '/groups/:id' => 'groups#schedule', as: 'group_schedule'
    get '/groups' => 'groups#list', as: 'groups'
    get '/profile' => 'users#profile', as: 'user_profile'
    get '/rooms/:id' => 'rooms#schedule', as: 'room_schedule'
    root to: 'teachers#current_user_schedule'
  end

  get '/:locale' => 'application#index'
end
