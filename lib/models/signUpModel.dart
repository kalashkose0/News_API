class signUpModel {
  String? email;
  String? password;
  String? username;
  String? id;
  String? createdAt;

  signUpModel(
      {this.email, this.password, this.username, this.id, this.createdAt});

  signUpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    username = json['username'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['username'] = this.username;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
