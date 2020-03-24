// File defines a user model class to associate properties with a Firebase user ID

class User {

  // user property: uid - Firebase User ID
  final String uid;

  // sets uid property
  User({ this.uid });

}

class UserData {

  final String uid;
  final String tasks;
  final String date;
  final String description;

  UserData({this.uid, this.tasks, this.date, this.description});

}