class XmlImportController < ApplicationController
include XmlImportHelper

  def import
    file = params[:file]
    if file.content_type == 'text/xml'
      # import_new_database(params[:file])

    else
      flash[:info] = 'Solo se admiten archivos XML'
      redirect_to root_url
    end
  end
end
