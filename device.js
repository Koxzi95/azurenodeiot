'use strict';

var clientFromConnectionString = require('azure-iot-device-amqp').clientFromConnectionString;
var Message = require('azure-iot-device').Message;
var ip = require('ip');
var moment = require ('moment');

var connectionString = 'HostName=ia3dockeriot.azure-devices.net;DeviceId=dockercontainerdevice01;SharedAccessKey=dbrYXUBvpcezLbsjKWB7mcCOZfaxSlcvsD/RrPH5Igs=';

var client = clientFromConnectionString(connectionString);

function printResultFor(op) {
  return function printResult(err, res) {
    if (err) console.log(op + ' error: ' + err.toString());
    if (res) console.log(op + ' status: ' + res.constructor.name);
  };
}

// Error catching.
var connectCallback = function (err) {
  if (err) {
    console.log('Could not connect: ' + err);
  } else {
    console.log('Client connected');

    // Create a message and send it to the IoT Hub every second
    setInterval(function(){
        var windSpeed = 10 + (Math.random() * 4);
        var temp = 2 + (Math.random() * 5);
        var timestamp = moment().format('lll');
        //var date = new Date();
        //var current_hour = date.getHours();
        var data = JSON.stringify({ deviceId: 'dockercontainerdevice01', windSpeed: windSpeed, temp: temp, timestamp: timestamp, ip: ip.address() });
        var message = new Message(data);
        console.log("Sending message: " + message.getData());
        client.sendEvent(message, printResultFor('send'));
    }, 1000);
  }
};

client.open(connectCallback);
