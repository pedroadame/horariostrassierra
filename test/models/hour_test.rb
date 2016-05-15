require 'test_helper'

class HourTest < ActiveSupport::TestCase

  def setup
    @hour = Hour.new(code: '12345', day: 1, hour: 1, start: '09:00', end: '10:00')
  end

  test 'deberia ser valido' do
    assert @hour.valid?
  end

  test 'codigo debe ser obligatorio' do
    @hour.code = '   '
    assert_not @hour.valid?
  end

  test 'dia debe estar entre 1..5' do
    @hour.day = 0
    assert_not @hour.valid?
    1.upto(5) do |n|
      @hour.day = n
      assert @hour.valid?
    end
    @hour.day = 6
    assert_not @hour.valid?
  end

  test 'hora debe estar entre 1..14' do
    @hour.hour = 0
    assert_not @hour.valid?
    1.upto(14) do |n|
      @hour.hour = n
      assert @hour.valid?
    end
    @hour.hour = 15
    assert_not @hour.valid?
  end

  test 'inicio debe ser obligatorio' do
    @hour.start = nil
    assert_not @hour.valid?
  end

  test 'fin debe ser obligatorio' do
    @hour.end = nil
    assert_not @hour.valid?
  end

  test 'debe aceptar horas validas' do
    horas_validas = %w(00:00 23:59 14:00 08:15 09:20 17:30)
    horas_validas.each do |hora|
      @hour.start = hora
      @hour.end = hora
      assert @hour.valid?, "#{hora} deberia ser valida"
    end
  end

  test 'debe rechazar horas invalidas' do
    horas_invalidas = %w(34:00 24:00 34:0 00;00 04:60 14::00 16.00 30:00 8:15 0:00)
    horas_invalidas.each do |hora|
      @hour.start = hora
      @hour.end = hora
      assert_not @hour.valid?, "#{hora} deberia ser invalida"
    end
  end

end
