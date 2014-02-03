require 'rubygems'
require 'arduino_firmata'
require 'linda-socket.io-client'
$stdout.sync = true

ENV['LINDA_BASE']  ||= 'http://node-linda-base.herokuapp.com'
ENV['LINDA_SPACE'] ||= 'test'

arduino = ArduinoFirmata.connect ENV['ARDUINO']

linda = Linda::SocketIO::Client.connect ENV['LINDA_BASE']
ts = linda.tuplespace(ENV['LINDA_SPACE'])

linda.io.on :connect do
  puts "connect!! <#{linda.url}/#{ts.name}>"
  puts " => #{linda.url}/#{ts.name}?type=door"
  last_at = Time.now
  ts.watch :type => :door, :cmd => :open do |err, tuple|
    next if err
    next if tuple.data.response
    next if last_at + 5 > Time.now
    p tuple.data
    arduino.servo_write 9, 0
    sleep 2
    arduino.servo_write 9, 180
    ts.write :type => :door, :cmd => :open, :response => 'success'
    last_at = Time.now
  end
end

linda.io.on :disconnect do
  puts "socket.io disconnect"
end

loop do
  sleep 1
end
