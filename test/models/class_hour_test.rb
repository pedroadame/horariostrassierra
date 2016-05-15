require 'test_helper'

class ClassHourTest < ActiveSupport::TestCase

  def setup
    @class = class_hours(:clase1)
  end

  test 'tiene que tener profesor' do
    @class.teacher = nil
    assert_not @class.valid?
  end

  test 'tiene que tener grupo' do
    @class.group = nil
    assert_not @class.valid?
  end

  test 'tiene que tener asignatura' do
    @class.subject = nil
    assert_not @class.valid?
  end

  test 'tiene que tener tramo horario' do
    @class.hour = nil
    assert_not @class.valid?
  end

  test 'tiene que tener aula' do
    @class.room = nil
    assert_not @class.valid?
  end
end
