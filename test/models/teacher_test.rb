require 'test_helper'

class TeacherTest < ActiveSupport::TestCase

  def setup
    @teacher = Teacher.new(abbreviation: 'LEN1', name: 'Profesor', level: 'LEN')
  end

  test 'debe ser valido' do
    assert @teacher.valid?
  end

  test 'abreviatura es obligatoria' do
    @teacher.abbreviation = '     '
    assert_not @teacher.valid?
  end

  test 'nombre es obligatorio' do
    @teacher.name = '     '
    assert_not @teacher.valid?
  end

  test 'nivel es opcional' do
    @teacher.level = '    '
    assert @teacher.valid?
  end

  test 'grupo debe ser opcional' do
    assert_nil @teacher.group
    otroprof = teachers(:jose)
    assert_not_nil otroprof.group
    assert otroprof.valid?
  end

  test 'debe devolver la hora de clase dada' do
    prof = teachers(:jose)
    clase = prof.search day: 1, hour: "09:00"
    assert_not_nil clase
    assert_equal clase.hour, hours(:lunes1)
  end

  test 'debe devolver la hora de clase actual' do
    prof = teachers(:jose)
    # Creo hora actual
    hora = Hour.new(code: '123', day: Time.now.wday, hour: 1, start: Time.now.beginning_of_hour.hh_mm, end: (Time.now + 1.hour).beginning_of_hour.hh_mm)
    hora.save!
    # Obtengo clase
    hora_clase = prof.class_hours.first
    # Asigno hora a clase
    # Asigno
    hora_clase.hour = hora
    # Guardo clase
    hora_clase.save!
    # Compruebo que el profesor está impartiendo clase actualmente
    assert_equal prof.search.hour, hora
  end
end
