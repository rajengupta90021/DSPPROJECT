class UserProfileImage {
  bool? success;
  String? message;
  String? url;

  UserProfileImage({this.success, this.message, this.url});

  UserProfileImage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['url'] = this.url;
    return data;
  }
}
