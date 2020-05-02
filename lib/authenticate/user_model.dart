// File defines a user model class to associate properties with a Firebase user ID

class User {

  // user property: uid - Firebase User ID
  String uid;

  // sets uid property
  User({ this.uid });

}

class UserData {

  String uid;
  String tasks;
  String date;
  String description;

  UserData({this.uid, this.tasks, this.date, this.description});

}