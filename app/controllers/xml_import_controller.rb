class XmlImportController < ApplicationController

  before_action :is_admin!

  def index
  end

  def import
    file = params[:file]
    if file.content_type == 'text/xml'
      @errors = import_new_database(file)
    else
      flash[:warning] = 'Solo se admiten archivos XML'
      redirect_to root_url
    end
  end

  private
  # TODO refactorizar esta mierda de codigo
  def import_new_database(file_data)
    doc = (Nokogiri::XML file_data.read).serialize(encoding: 'UTF-8') do |c|
      c.format.as_xml
    end
    xml = Nokogiri::XML doc
    Dir.chdir Rails.public_path do
      schema = Nokogiri::XML::Schema(IO.read('database.xsd'))
      errors = schema.validate(xml)
      valido = schema.valid? xml
      if valido && errors.empty?
        logger.debug '---------------- Todo correcto'
        replace_db xml
        []
      else
        logger.debug '---------------- Hay errores'
        errors.each do |e|
          logger.debug "Error: #{e.message}"
        end
        errors
      end
    end
  end

  def replace_db(new_data)
    ClassHour.destroy_all
    Group.destroy_all
    Hour.destroy_all
    Teacher.destroy_all
    Subject.destroy_all
    Room.destroy_all
    User.destroy_all
    User.create!(email: "admin@iestrassierra.com", password: "administrator", admin: true)
    process_data new_data
  end

  def process_data(data)
    data.xpath("//ASIGNATURA").each do |a|
      Subject.create!(id: a['num_int_as'],
                      abbreviation: a['abreviatura'],
                      name: a['nombre'],
                      level: a['nivel'],
                      code: a['codigo'],
                      course: a['curso'])
    end

    data.xpath("//PROFESOR").each do |p|
      Teacher.create!(id: p['num_int_pr'],
                      abbreviation: p['abreviatura'],
                      name: p['nombre'],
                      level: p['level'])
    end

    data.xpath("//GRUPO").each do |g|
      Group.create!(id: g['num_int_gr'],
                    abbreviation: g['abreviatura'],
                    name: g['nombre'],
                    level: g['nivel'],
                    code: g['codigo'],
                    course: g['curso'],
                    teacher_id: g['num_pr_tutor_principal'])
    end

    data.xpath("//AULA").each do |a|
      Room.create!(id: a['num_int_au'],
                   abbreviation: a['abreviatura'],
                   name: a['nombre'],
                   level: a['nivel'])
    end

    data.xpath("//TRAMO").each do |t|
      Hour.create!(id: t['num_tr'],
                   code: t['codigo'],
                   day: t['numero_dia'],
                   hour: t['numero_hora'],
                   start: t['hora_inicio'],
                   end: t['hora_final'])
    end

    data.xpath("//HORARIO_PROF").each do |h|
      prof = h['hor_num_int_pr']
      h.xpath("ACTIVIDAD").each do |a|
        tramo = a['tramo']
        asignatura = a['asignatura']
        aula = a['aula']
        a.xpath("GRUPOS_ACTIVIDAD").first.drop(1).each do |i, grupo|
          ClassHour.create!(teacher_id: prof,
                                room_id: aula, hour_id: tramo, group_id: grupo, subject_id: asignatura)
        end
      end
    end
  end

  def is_admin!
    unless current_user.admin?
      flash[:notice] = "No tienes permiso"
      redirect_to root_url
    end
  end

end
