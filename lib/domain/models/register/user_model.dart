class UserModel {
  String email, password, name;
  // userId


  UserModel(
      {
        // required this.userId,
      required this.email,
      required this.password,
      required this.name});

  factory UserModel.fromDoc(Map<String, dynamic> doc) {
    return UserModel(
        // userId: doc["userId"],
        email: doc["email"],
        password: doc["password"],
        name: doc["name"]);
  }

  Map<String, dynamic> toDoc() {
    return {
      // "userId": userId,
      "email": email,
      "password": password,
      "name": name
    };
  }
}
