class LoginModel {
  String? username;
  String? password;
  int? source;

  LoginModel({this.username, this.password, this.source});

  LoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['source'] = source;
    return data;
  }
}
