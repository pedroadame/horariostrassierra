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

end
