class UserData {
  String? id;
  Data? data;
  String? path;

  UserData({this.id, this.data, this.path});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['path'] = this.path;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? password;
  String? mobile;
  String? profileImg;
  String? role;
  String? dob;
  String? gender;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.name,
        this.email,
        this.password,
        this.mobile,
        this.profileImg,
        this.dob,
        this.gender,
        this.role,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    mobile = json['mobile'];
    profileImg = json['profile_img'];
    role = json['role'];
    dob = json['dob'];
    gender = json['gender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['profile_img'] = this.profileImg;
    data['role'] = this.role;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
