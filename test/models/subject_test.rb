require 'test_helper'

class SubjectTest < ActiveSupport::TestCase

  def setup
    @subject = Subject.new(abbreviation: 'LEN', name: 'Lengua', level: '1ESO', code: '1234', course: '1 de ESO')
  end

  test 'debe ser valido' do
    assert @subject.valid?
  end

  test 'abreviatura es obligatoria' do
    @subject.abbreviation = '  '
    assert_not @subject.valid?
  end

  test 'nombre es obligatorio' do
    @subject.name = '  '
    assert_not @subject.valid?
  end

  test 'nivel es obligatorio' do
    @subject.code = '     '
    assert_not @subject.valid?
  end

  test 'curso es obligatorio' do
    @subject.course = '    '
    assert_not @subject.valid?
  end
end
