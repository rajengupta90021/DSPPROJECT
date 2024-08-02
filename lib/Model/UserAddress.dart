class UserAdress {
  String? id;
  Data? data;

  UserAdress({this.id, this.data});

  UserAdress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? uid;
  String? updatedAt;
  String? createdAt;
  String? currentAddress;
  String? otherAddress;
  String? permanentAddress;

  Data(
      {this.uid,
        this.updatedAt,
        this.createdAt,
        this.currentAddress,
        this.otherAddress,
        this.permanentAddress});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    currentAddress = json['current_address'];
    otherAddress = json['other_address'];
    permanentAddress = json['permanent_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.updatedAt ;
    data['current_address'] = this.currentAddress;
    data['other_address'] = this.otherAddress;
    data['permanent_address'] = this.permanentAddress;
    return data;
  }

}
