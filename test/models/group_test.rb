require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @group = Group.new(abbreviation: '1ESOA', name: 'Primero de ESO', level: 'ESO', code: '232323', course: '1 ESO')
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

  test 'nivel es obligatorio' do
    @group.level = '   '
    assert_not @group.valid?
  end

  test 'codigo es obligatorio' do
    @group.code = '   '
    assert_not @group.valid?
  end

  test 'curso es obligatorio' do
    @group.course = '  '
    assert_not @group.valid?
  end

  test 'tiene profesor opcional' do
    assert_nil @group.teacher
    grupo = groups(:daw)
    assert_not_nil grupo.teacher
    assert grupo.valid?
  end
end
