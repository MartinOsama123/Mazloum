class UserModel {
  late String firstName;
  late String lastName;
  late String password;
  late String email;
  late String phone;

  UserModel(this.firstName, this.lastName, this.password, this.email, this.phone);
  UserModel.fromJson(Map<String, dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}