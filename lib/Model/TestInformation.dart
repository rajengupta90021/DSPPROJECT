import 'package:get/get.dart';

class TestInformation {
  final String? id;
  final dynamic rates;
  final String? preTestInformation;
  final dynamic sNo;
  final String? staiblilityRoom;
  final String? method;
  final String? reporting;
  final String? tests;
  final String? specimen;
  final String? staiblilityRefrigerated;
  final String? sampleColl;
  final String? parametersCovered;
  final String? staiblilityFrozen;
  final String? reportDelivery;

  TestInformation({
    required this.id,
    required this.rates,
    this.preTestInformation = '',
    required this.sNo,
    required this.staiblilityRoom,
    required this.method,
    required this.reporting,
    required this.tests,
    required this.specimen,
    required this.staiblilityRefrigerated,
    required this.sampleColl,
    required this.parametersCovered,
    required this.staiblilityFrozen,
    required this.reportDelivery,
  });



  factory TestInformation.fromJson(Map<String, dynamic> json) {
    return TestInformation(
      id: json['id'] ?? '',
      rates: json['Rates(Rs)'] ?? 0,
      preTestInformation: json['Pre Test Information'] ?? '',
      sNo: json['S_ No_'] ?? 0,
      staiblilityRoom: json['Staiblility Room'] ?? '',
      method: json['Method'] ?? '',
      reporting: json['Reporting'] ?? '',
      tests: json['Tests'] ?? '',
      specimen: json['Specimen'] ?? '',
      staiblilityRefrigerated: json['Staiblility Refrigerated'] ?? '',
      sampleColl: json['Sample Coll_'] ?? '',
      parametersCovered: json['Parameters Covered'] ?? '',
      staiblilityFrozen: json['Staiblility Frozen'] ?? '',
      reportDelivery: json['Report Delivery'] ?? '',
    );
  }
  Map<String, Object?> toJson() {
    return {
      'id': id,
      'Rates(Rs)': rates,
      'Pre Test Information': preTestInformation,
      'S_ No_': sNo,
      'Staiblility Room': staiblilityRoom,
      'Method': method,
      'Reporting': reporting,
      'Tests': tests,
      'Specimen': specimen,
      'Staiblility Refrigerated': staiblilityRefrigerated,
      'Sample Coll_': sampleColl,
      'Parameters Covered': parametersCovered,
      'Staiblility Frozen': staiblilityFrozen,
      'Report Delivery': reportDelivery,
    };
  }
  Map<String, Object?> toMap(){
    return {
      'id' : id ,
      'Rates(Rs)': rates,
      'Pre Test Information': preTestInformation,
      'S_ No_': sNo,
      'Staiblility Room': staiblilityRoom,
      'Method': method,
      'Reporting': reporting,
      'Tests': tests,
      'Specimen': specimen,
      'Staiblility Refrigerated': staiblilityRefrigerated,
      'Sample Coll_': sampleColl,
      'Parameters Covered': parametersCovered,
      'Staiblility Frozen': staiblilityFrozen,
      'Report Delivery': reportDelivery,
    };
  }
}


class TestCart {
  final String id;
  final int? rates;
  final String? sampleColl;
  final String? reporting;
  final String? tests;

  TestCart({
    required this.id,
    required this.rates,
    required this.sampleColl,
    required this.reporting,
    required this.tests,
  });

  TestCart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'] ?? '',
        rates = res['rates'], // Assuming rates can be any type
        sampleColl = res['sampleColl'],
        reporting = res['reporting'],
        tests = res['tests'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'rates': rates,
      'sampleColl': sampleColl,
      'reporting': reporting,
      'tests': tests,
    };
  }
}

