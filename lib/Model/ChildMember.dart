
class childmember {
  String? id;
  Data? data;
  String? path;

  childmember({this.id, this.data, this.path});

  childmember.fromJson(Map<String, dynamic> json) {
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
  String? parentId;
  String? name;
  String? email;
  String? address;
  String? mobile;
  String? profileImg;
  String? relation;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.parentId,
        this.name,
        this.email,
        this.address,
        this.mobile,
        this.profileImg,
        this.relation,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    parentId = json['parentId'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    mobile = json['mobile'];
    profileImg = json['profile_img'];
    relation = json['relation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parentId'] = this.parentId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['profile_img'] = this.profileImg;
    data['relation'] = this.relation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
