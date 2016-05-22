require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @group = Group.new(abbreviation: '1ESOA', name: 'Primero de ESO',
                       level: 'ESO', code: '232323', course: '1 ESO')
  end

  test 'debe ser valido' do
    assert @group.valid?
  end

  test 'abreviatura es obligatoria' do
    @group.abbreviation = '   '
    assert_not @group.valid?
  end

  test 'nombre es obligatorio' do
    @group.name = '   '
    assert_not @group.valid?
  end

  test 'nivel es opcional' do
    @group.level = '   '
    assert @group.valid?
  end

  test 'codigo es opcional' do
    @group.code = '   '
    assert @group.valid?
  end

  test 'curso es opcional' do
    @group.course = '  '
    assert @group.valid?
  end

  test 'tiene profesor opcional' do
    assert_nil @group.teacher
    grupo = groups(:daw)
    assert_not_nil grupo.teacher
    assert grupo.valid?
  end


  # TODO: Preguntar a City como mejorar esta mierda
  # Probablemente se arregle cuando se cierre #9
  test 'devuelve hora de clase actual' do
    group = groups(:daw)
    hora_clase_actual = group.search
    if hora_clase_actual.nil?
      group.class_hours.build(hour: create_actual_hour,
                              teacher: teachers(:jose),
                              room: rooms(:i1),
                              subject: subjects(:php))
      group.save!
      group.reload
    end
    hora_clase_actual = group.search
    assert_not_nil hora_clase_actual
    assert_equal hora_clase_actual.hour, Hour.now
  end

  test 'devuelve el profesor que le da clase en este momento' do
    group = groups(:daw)
    hora_clase_actual = group.search
    if hora_clase_actual.nil?
      group.class_hours.build(hour: create_actual_hour,
                              teacher: teachers(:jose),
                              room: rooms(:i1),
                              subject: subjects(:php))
      group.save!
      group.reload
    end
    assert_not_nil group.actual_teacher
    assert_equal group.actual_teacher, teachers(:jose)
  end

  test 'devuelve nil cuando no tiene clase ahora' do
    g = groups(:daw)
    ClassHour.where(group: g).delete_all
    assert_nil g.actual_teacher
  end

  test 'obtiene el equipo educativo' do
    g = groups(:daw)
    assert_equal 2, g.teachers.count
    assert_not_nil g.teachers.where(id: teachers(:jose).id)
    assert_not_nil g.teachers.where(id: teachers(:elena).id)
  end
end
