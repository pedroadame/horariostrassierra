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

  test 'dia debe estar entre 0..6' do
    @hour.day = -1
    assert_not @hour.valid?
    0.upto(6) do |n|
      @hour.day = n
      assert @hour.valid?
    end
    @hour.day = 7
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
    @hour.start = '   '
    assert_not @hour.valid?
  end

  test 'fin debe ser obligatorio' do
    @hour.end = '   '
    assert_not @hour.valid?
  end

  test 'debe aceptar horas validas' do
    horas_validas = %w(00:00 23:59 14:00 8:15 08:15 09:20 17:30)
    horas_validas.each do |hora|
      @hour.start = hora
      @hour.end = hora
      assert @hour.valid?, "#{hora} deberia ser valida"
    end
    @hour.start = ' 9:00'
    @hour.end = '10:00'
    assert @hour.valid?
  end

  test 'debe rechazar horas invalidas' do
    horas_invalidas = %w(34:00 24:00 34:0 00;00 04:60 14::00 16.00 30:00)
    horas_invalidas.each do |hora|
      @hour.start = hora
      @hour.end = hora
      assert_not @hour.valid?, "#{hora} deberia ser invalida"
    end
  end

  test 'debe procesar horas en formato #:## y _#:##' do
    @hour.start = ' 0:00'
    @hour.end = '9:00'
    assert @hour.valid?
    assert_equal @hour.start, '00:00'
    assert_equal @hour.end, '09:00'
  end

  test 'debe devolver hora actual' do
    hora = Hour.now
    if hora.nil?
      create_actual_hour
      assert_not_nil Hour.now
    else
      assert_equal hora.day, Time.now.wday
      assert_equal hora.start, Time.now.beginning_of_hour.hh_mm
      assert_equal hora.end, (Time.now + 1.hour).beginning_of_hour.hh_mm
    end
  end

  test 'debe devolver hora solicitada' do
    assert_nil Hour.search day: 2, hour: "19:34"
    h_start = Time.now.change(hour: 19, min: 00).hh_mm
    h_end = Time.now.change(hour: 20, min: 00).hh_mm
    Hour.create!(code: '123', day: 2, hour: 1, start: h_start, end: h_end)
    assert_not_nil Hour.search day: 2, hour: "19:34"
  end

  test 'debe devolver hora solicitada y dia actual' do
    assert_nil Hour.search hour: "19:34"
    h_start = Time.now.change(hour: 19, min: 00).hh_mm
    h_end = Time.now.change(hour: 20, min: 00).hh_mm
    Hour.create!(code: '123', day: Time.now.wday, hour: 1, start: h_start, end: h_end)
    h = Hour.search hour: "19:34"
    assert_not_nil h
    assert_equal h.day, Time.now.wday
  end

  test 'debe devolver dia solicitado y hora actual' do
    hora = Hour.search day: 5
    h_start = Time.now.beginning_of_hour.hh_mm
    h_end =  (Time.now + 1.hour).beginning_of_hour.hh_mm
    if hora.nil?
      Hour.create!(code: '123', day: 5, hour: 1, start: Time.now.beginning_of_hour.hh_mm, end: (Time.now + 1.hour).beginning_of_hour.hh_mm)
      hora = Hour.search day: 5
    end
    assert_not_nil hora
    assert_equal hora.start, h_start
    assert_equal hora.end, h_end
  end

  test 'debe procesar la hora no escrita en formato ##:## al buscar' do
    assert_nil Hour.search day: 2, hour: "9:00"
    h_start = Time.now.change(hour: 8, min: 15).hh_mm
    h_end = Time.now.change(hour: 9, min: 15).hh_mm
    Hour.create!(code: '123', day: 2, hour: 1, start: h_start, end: h_end)
    h = Hour.search day: 2, hour: "9:00"
    assert_not_nil h
    assert_equal h.start, "08:15"
    assert_equal h.end, "09:15"
  end
end
