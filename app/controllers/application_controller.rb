# Clase ApplicationController.
# Provee de funcionalidad adicional a todos los controladores.
class ApplicationController < ActionController::Base
  # Previene ataques CSRF
  protect_from_forgery with: :exception

  def index
  end
end
