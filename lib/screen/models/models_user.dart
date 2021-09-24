class UserModel {
  UserModel.init() {
    this.name = 'User name';
  }

  // ignore: non_constant_identifier_names
  late String id, name, username, akses;

  UserModel.fromjson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.username = json["username"];
    this.akses = json["akses"];
  }
  static List<UserModel> userlist = [];
}
