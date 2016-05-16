require 'nokogiri'
module XmlImportHelper

  def import_new_database(file_data)
    doc = (Nokogiri::XML file_data.read).serialize(encoding: 'UTF-8') do |c|
      c.format.as_xml
    end
    xml = Nokogiri::XML doc
    Dir.chdir Rails.public_path do
      schema = Nokogiri::XML::Schema(IO.read('database.xsd'))
      val = schema.validate(xml)
      valido = schema.valid? xml
      if valido && val.empty?
        logger.debug '---------------- Todo correcto'
        replace_db xml
      else
        logger.debug '---------------- Hay errores'
        val.each do |e|
          logger.debug "Error: #{e.message}"
        end
      end
    end
  end

  private
  def replace_db(new_data)
    `rake db:schema:load`
    process_data new_data
  end

  def process_data(data)
    data.xpath("//ASIGNATURA").each do |a|
      Subject.create!(abbreviation: a['abreviatura'], name: a['nombre'], level: a['nivel'], code: a['codigo'], course: a['curso'])
    end

    data.xpath("//PROFESOR").each do |p|
      Teacher.create!(abbreviation: p['abreviatura'], name: p['nombre'], level: p['level'])
    end

    data.xpath("//GRUPO").each do |g|
      Group.create!(abbreviation: g['abreviatura'], name: g['nombre'], level: g['nivel'], code: g['codigo'], course: g['curso'], teacher_id: g['num_pr_tutor_principal'])
    end

    data.xpath("//AULA").each do |a|
      Room.create!(abbreviation: a['abreviatura'], name: a['nombre'], level: a['nivel'], code: a['codigo'])
    end

    data.xpath("//TRAMO").each do |t|
      Hour.create!(code: t['codigo'], day: t['numero_dia'], hour: t['numero_hora'], start: t['hora_inicio'], end: t['hora_final'])
    end
  end

end
