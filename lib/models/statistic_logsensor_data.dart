class TimeDuration {
  var date, duration;
  TimeDuration(this.date, this.duration);
}

class LogSensorData {
  var sensor_id;
  List<TimeDuration> sensor_data;
  LogSensorData(this.sensor_id, this.sensor_data);
}
