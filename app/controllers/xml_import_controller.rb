class XmlImportController < ApplicationController
include XmlImportHelper

  def import
    import_new_database(params[:file])
  end
end
