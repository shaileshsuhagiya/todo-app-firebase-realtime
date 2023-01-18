class UserModel {
  String? uid;
  String? email;
  String? name;
  String? password;
  String? profileUrl;

  UserModel({this.uid, this.email, this.name, this.password,this.profileUrl});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
      profileUrl: map['profile_url'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'profile_url': profileUrl,
    };
  }
}