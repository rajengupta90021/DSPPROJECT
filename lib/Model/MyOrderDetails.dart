class OrderDetails {
  String? userId;
  String? OrderId;
  String? username;
  String? email;
  String? mobile;
  String? dob;
  String? gender;
  String? profileImg;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? childName;
  String? childUserRelation;
  String? childUserPhone;
  String? childUserDob;
  String? childuseremail;
  String? parentChildUserAddress;
  String? childUserHouseNo;
  String? childUserPinCode;
  String? childUserCity;
  String? childUserState;
  String? orderDate;
  String? selectedDate;
  String? startTime;
  String? endTime;
  int? totalAmount;
  List<CartItems>? cartItems;
  String? orderStatus;
  String? paymentStatus;
  String? testReport;
  String? sampleCollected;
  String? id;
  String? password;

  OrderDetails(
      {this.userId,
      this.OrderId,
        this.username,
        this.email,
        this.mobile,
        this.dob,
        this.gender,
        this.profileImg,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.childName,
        this.childUserRelation,
        this.childUserPhone,
        this.childUserDob,
        this.childuseremail,
        this.parentChildUserAddress,
        this.childUserHouseNo,
        this.childUserPinCode,
        this.childUserCity,
        this.childUserState,
        this.orderDate,
        this.selectedDate,
        this.startTime,
        this.endTime,
        this.totalAmount,
        this.cartItems,
        this.orderStatus,
        this.paymentStatus,
        this.testReport,
        this.sampleCollected,
        this.id,
        this.password});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    OrderId = json['OrderId'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    profileImg = json['profileImg'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    childName = json['childName'];
    childUserRelation = json['childUserRelation'];
    childUserPhone = json['childUserPhone'];
    childUserDob = json['childUserDob'];
    childuseremail = json['childuseremail'];
    parentChildUserAddress = json['parentChildUserAddress'];
    childUserHouseNo = json['childUserHouseNo'];
    childUserPinCode = json['childUserPinCode'];
    childUserCity = json['childUserCity'];
    childUserState = json['childUserState'];
    orderDate = json['orderDate'];
    selectedDate = json['selectedDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    totalAmount = json['totalAmount'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    orderStatus = json['orderStatus'];
    paymentStatus = json['paymentStatus'];
    testReport = json['testReport'];
    sampleCollected = json['sampleCollected'];
    id = json['id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['OrderId'] = this.OrderId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profileImg'] = this.profileImg;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['childName'] = this.childName;
    data['childUserRelation'] = this.childUserRelation;
    data['childUserPhone'] = this.childUserPhone;
    data['childUserDob'] = this.childUserDob;
    data['childuseremail'] = this.childuseremail;
    data['parentChildUserAddress'] = this.parentChildUserAddress;
    data['childUserHouseNo'] = this.childUserHouseNo;
    data['childUserPinCode'] = this.childUserPinCode;
    data['childUserCity'] = this.childUserCity;
    data['childUserState'] = this.childUserState;
    data['orderDate'] = this.orderDate;
    data['selectedDate'] = this.selectedDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['totalAmount'] = this.totalAmount;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['orderStatus'] = this.orderStatus;
    data['paymentStatus'] = this.paymentStatus;
    data['testReport'] = this.testReport;
    data['sampleCollected'] = this.sampleCollected;
    data['id'] = this.id;
    data['password'] = this.password;
    return data;
  }
}

class CartItems {
  String? id;
  int? rates;
  String? sampleColl;
  String? reporting;
  String? tests;

  CartItems({this.id, this.rates, this.sampleColl, this.reporting, this.tests});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rates = json['rates'];
    sampleColl = json['sampleColl'];
    reporting = json['reporting'];
    tests = json['tests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rates'] = this.rates;
    data['sampleColl'] = this.sampleColl;
    data['reporting'] = this.reporting;
    data['tests'] = this.tests;
    return data;
  }
}
