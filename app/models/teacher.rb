class Teacher < ActiveRecord::Base
  # Validaciones de atributos
  validates :abbreviation, presence: true
  validates :name, presence: true
  default_scope -> { order(name: :asc) }
  # Relación con su tutoría.
  # Nos permite acceder a la tutoría del profesor (de tenerla)
  # de forma simple.
  has_one :group
  has_many :class_hours
  has_many :groups, -> { distinct }, through: :class_hours
  has_one :user

  class << self
    def in_guard
      ts = Teacher.all
      guardia = Subject.find_by_name "GUARDIA"
      ahora = Hour.now
      guardias = []
      ts.each do |t|
        guardias << t unless t.class_hours.where(hour: ahora, subject:
            guardia).count == 0
      end
      guardias
    end

    def wo_account(params = {})
      teachers = []
      Teacher.all.each do |t|
        teachers << t if t.user.nil?
      end
      teachers
    end

    def search(query)
      q = query.replace_rare_chars
      teachers = []
      Teacher.all.each do |t|
        if t.name.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s.start_with?(q) || t.abbreviation.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s.start_with?(q) || t.humanize.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s.start_with?(q)
          teachers << t
        end
      end
      teachers
    end
  end

  def search(params = {})
    self.class_hours.where(hour: Hour.search(day: params[:day],
                                             hour: params[:hour])).first
  end

  def has_group?
    !self.group.nil?
  end

  def humanize
    regex = /(.*) (.*),\s?(.*)/
    matches = self.name.match regex
    a = matches.to_a
    a.shift
    b = a.pop
    a.unshift(b).join " "
  end

  def schedule
    ids = ClassHour.find_by_sql(['SELECT max(class_hours.id) mid FROM class_hours inner join hours on class_hours.hour_id = hours.id inner join rooms on class_hours.room_id = rooms.id where class_hours.teacher_id = ? group by hours.id, rooms.id ORDER BY hours.day, hours.hour', self.id]).map { |x| x['mid'] }
    horas_clase = []
    ids.each do |id|
      horas_clase << ClassHour.find(id)
    end
    horas_clase
  end
end
