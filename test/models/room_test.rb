require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  def setup
    @room = Room.new(abbreviation: 'I3', name: 'Informatica 3', level: 'FPGS')
  end

  test 'debe ser valido' do
    assert @room.valid?
  end

  test 'abreviatura es opcional' do
    @room.abbreviation = '  '
    assert @room.valid?
  end

  test 'nombre es obligatorio' do
    @room.name = '  '
    assert_not @room.valid?
  end

  test 'nivel es opcional' do
    @room.level = '   '
    assert @room.valid?
  end

  test 'aulas vacias' do
    create_actual_hour if Hour.now.nil?
    Room.destroy_all
    Room.create!(name: 'Aula vacía')
    Room.create!(name: 'Aula vacía 2')
    assert_not_nil Room.empties
    assert_equal 2, Room.empties.count
  end
end
