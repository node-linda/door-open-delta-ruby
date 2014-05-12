door-open-delta-ruby
====================
Open [DeltaS112](http://gyazz.com/masuilab/慶應SFC 増井研究会) door with [linda-socket.io](https://github.com/node-linda/linda-socket.io)

- https://github.com/node-linda/door-open-delta-ruby


1. watch {type: "door", cmd: "open"}
2. open door
3. then, write {type: "door", cmd: "open", response: "success"}


Video
-----
http://www.youtube.com/watch?v=mHJhTMvtmPQ

Dependencies
------------
- [Servo Motor](http://akizukidenshi.com/catalog/g/gM-01794/)
- [Arduino Firmata](https://github.com/shokai/arduino_firmata)


## Install Dependencies

    % gem install bundler foreman
    % bundle install


## Setup Arduino

Install Arduino Firmata v2.2

    Arduino IDE -> [File] -> [Examples] -> [Firmata] -> [StandardFirmata]

servo motor -> digital pin 9


## Run

    % foreman start

=> http://node-linda-base.herokuapp.com/test?type=door


## Run with your [linda-base](https://github.com/node-linda/node-linda-base)

    % export LINDA_BASE=http://node-linda-base.herokuapp.com
    % export LINDA_SPACE=test
    % foreman start


## Install as Service

    % gem install foreman

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app ruby-linda-door-open-delta -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/ruby-linda-door-open-delta-main-1.plist


for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app ruby-linda-door-open-delta -d `pwd` -u `whoami`
    % sudo service ruby-linda-door-open-delta start
