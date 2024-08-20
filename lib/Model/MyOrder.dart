import 'dart:convert';

class Order {
  final String orderId;
  final String userId;
  final String username;
  final String email;
  final String password;
  final String mobile;
  final String profileImg;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String childName;
  final String childUserRelation;
  final String childUserPhone;
  final String childUserDob;
  final String parentChildUserAddress;
  final String childUserHouseNo;
  final String childUserPinCode;
  final String childUserCity;
  final String childUserState;
  final DateTime selectedDate;
  final String startTime;
  final String endTime;
  final double totalAmount;
  final String cartItems; // JSON string
  final String orderStatus; // New field
  final String paymentStatus; // New field
  final DateTime? deliveryDate; // New field, nullable

  Order({
    required this.orderId,
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.mobile,
    required this.profileImg,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.childName,
    required this.childUserRelation,
    required this.childUserPhone,
    required this.childUserDob,
    required this.parentChildUserAddress,
    required this.childUserHouseNo,
    required this.childUserPinCode,
    required this.childUserCity,
    required this.childUserState,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
    required this.cartItems,
    required this.orderStatus, // New field
    required this.paymentStatus, // New field
    this.deliveryDate, // New field
  });

  // Convert Order to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'mobile': mobile,
      'profileImg': profileImg,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'childName': childName,
      'childUserRelation': childUserRelation,
      'childUserPhone': childUserPhone,
      'childUserDob': childUserDob,
      'parentChildUserAddress': parentChildUserAddress,
      'childUserHouseNo': childUserHouseNo,
      'childUserPinCode': childUserPinCode,
      'childUserCity': childUserCity,
      'childUserState': childUserState,
      'selectedDate': selectedDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'totalAmount': totalAmount,
      'cartItems': cartItems,
      'orderStatus': orderStatus, // New field
      'paymentStatus': paymentStatus, // New field
      'deliveryDate': deliveryDate?.toIso8601String(), // New field
    };
  }

  // Convert a Map to Order
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'],
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      mobile: map['mobile'],
      profileImg: map['profileImg'],
      role: map['role'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      childName: map['childName'],
      childUserRelation: map['childUserRelation'],
      childUserPhone: map['childUserPhone'],
      childUserDob: map['childUserDob'],
      parentChildUserAddress: map['parentChildUserAddress'],
      childUserHouseNo: map['childUserHouseNo'],
      childUserPinCode: map['childUserPinCode'],
      childUserCity: map['childUserCity'],
      childUserState: map['childUserState'],
      selectedDate: DateTime.parse(map['selectedDate']),
      startTime: map['startTime'],
      endTime: map['endTime'],
      totalAmount: map['totalAmount'],
      cartItems: map['cartItems'],
      orderStatus: map['orderStatus']?? 'PENDING', // New field
      paymentStatus: map['paymentStatus'] ?? 'PENDING', // New field
      deliveryDate: map['deliveryDate'] != null ? DateTime.tryParse(map['deliveryDate'] ?? '') ?? DateTime.now().add(Duration(days: 30)) : DateTime.now().add(Duration(days: 30)),
    );
  }

  // Convert Order to JSON
  String toJson() {
    final Map<String, dynamic> data = toMap();
    return jsonEncode(data);
  }

  // Convert JSON to Order
  factory Order.fromJson(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Order.fromMap(data);
  }
}
