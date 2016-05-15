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

end
