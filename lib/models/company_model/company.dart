import 'package:beasy_company/models/company_model/company_category.dart';
import 'package:beasy_company/models/company_model/company_stream.dart';

class Company {
  String companyId;
  String companyOwnerId;
  String companyName;
  String copmanyAdress;
  String companyDescription;
  List<String> companyImages;
  List<String> workDays;
  DateTime startTime;
  DateTime endTime;
  String companyAvatar;
  List<CompanyCategory> companyCategories;
  List<CompanyStream> companyStreams = [];

  Company({
    this.companyId,
    this.endTime,
    this.startTime,
    this.workDays,
    this.companyCategories,
    this.companyDescription,
    this.companyOwnerId,
    this.companyName,
    this.companyAvatar,
    this.companyImages,
    this.copmanyAdress,
  });

  factory Company.fromJson(json) {
    return Company(
      copmanyAdress: json["companyAdress"],
      workDays: json['workDays'] != null
          ? (json['workDays'] as List).map((e) => e.toString()).toList()
          : null,
      companyId: json["companyId"],
      startTime: json['startTime'],
      endTime: json['endTime'],
      companyCategories: json["companyCategories"] != null
          ? (json["companyCategories"] as List)
              .map((e) => CompanyCategory.fromJson(e))
              .toList()
          : null,
      companyDescription: json["companyDescription"],
      companyOwnerId: json["companyOwnerId"],
      companyName: json["companyName"],
      companyAvatar: json["companyAvatar"],
      companyImages: json["companyImages"] != null
          ? (json["companyImages"] as List).map((e) => e.toString()).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["companyId"] = this.companyId;
    data["companyOwnerId"] = this.companyOwnerId;
    data["companyAdress"] = this.copmanyAdress;
    data["companyDescription"] = this.companyDescription;
    data['endTime'] = this.endTime;
    data['startTime'] = this.startTime;
    data['workDays'] = this.workDays;
    data["companyCategories"] = this.companyCategories != null
        ? this.companyCategories.map((e) => e.toJson()).toList()
        : null;
    data["companyName"] = this.companyName;
    data["companyImages"] = this.companyImages ?? null;
    data["companyAvatar"] = this.companyAvatar;
    return data;
  }
}
