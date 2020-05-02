// Code from https://github.com/immacoder/bookclub/tree/INTEGRATION_BUILD_0_1

class OurTimeLeft {
  String timeLeft(DateTime due) {
    String retVal;

    retVal = "test";

//    Duration _timeUntilDue = due.difference(DateTime.now());
//
//    int _daysUntil = _timeUntilDue.inDays;
//    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
//    int _minUntil = _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
//    int _secUntil = _timeUntilDue.inSeconds -
//        (_daysUntil * 24 * 60 * 60) -
//        (_hoursUntil * 60 * 60) -
//        (_minUntil * 60);
//
//    if (_daysUntil > 0) {
//      retVal = _daysUntil.toString() +
//          " days\n" +
//          _hoursUntil.toString() +
//          " hours\n" +
//          _minUntil.toString() +
//          " mins\n" +
//          _secUntil.toString() +
//          " secs";
//    } else if (_hoursUntil > 0) {
//      retVal = _hoursUntil.toString() +
//          " hours\n" +
//          _minUntil.toString() +
//          " mins\n" +
//          _secUntil.toString() +
//          " secs";
//    } else if (_minUntil > 0) {
//      retVal = _minUntil.toString() + " mins\n" + _secUntil.toString() + " secs";
//    } else if (_secUntil > 0) {
//      retVal = _secUntil.toString() + " secs";
//    } else {
//      retVal = "error";
//    }
//
    return retVal;
  }
}