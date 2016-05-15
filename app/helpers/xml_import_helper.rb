require 'nokogiri'
module XmlImportHelper

  def import_new_database(file_data)
    file = file_data
    doc = Nokogiri::XML file.read
    doc = doc.serialize(encoding: 'UTF-8') { |c| c.format.as_xml }
    xml = Nokogiri::XML doc
    Dir.chdir Rails.public_path do
      schema = Nokogiri::XML::Schema(IO.read('database.xsd'))
      val = schema.validate(xml)
      valido = schema.valid? xml
      replace_db xml.to_s if valido && val.empty?
    end
  end

  private
  def replace_db(new_data)
    `rake db:schema:load`
    process_data new_data
  end

  def process_data(data)
    # TODO Parse XML
  end
end
