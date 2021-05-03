import 'package:beasy_company/models/company_model/company_stream_service.dart';
import 'package:beasy_company/models/company_model/stream_queue_item.dart';

class CompanyStream {
  String companyStreamId;
  String streamName;
  String streamDescription;
  bool companyStreamState;
  String avatar;
  List<String> streamImages;
  List<StreamQueueItem> queue = [];
  List<CompanyStreamService> streamServices = [];

  CompanyStream({
    this.avatar,
    this.companyStreamId,
    this.streamImages,
    this.streamName,
    this.streamServices,
    this.streamDescription,
    this.companyStreamState = false,
  });

  factory CompanyStream.fromJson(json) {
    return CompanyStream(
      avatar: json["avatar"],
      companyStreamId: json["companyStreamId"],
      streamName: json["streamName"],
      streamDescription: json["streamDescription"],
      streamImages: json["streamImages"] != null
          ? (json["streamImages"] as List).map((e) => e.toString()).toList()
          : null,
      streamServices: json["streamServices"] != null
          ? (json["streamServices"] as List)
              .map((element) => CompanyStreamService.fromJson(element))
              .toList()
          : null,
      companyStreamState: json["companyStreamState"] != null
          ? json["companyStreamState"] as bool
          : false,
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["companyStreamId"] = this.companyStreamId;
    data["avatar"] = this.avatar;
    data["streamName"] = this.streamName;
    data["streamDescription"] = this.streamDescription;
    data["streamImages"] = this.streamImages;
    data["streamServices"] = this.streamServices != null
        ? this.streamServices.map((e) => e.toJson()).toList()
        : null;
    data["companyStreamState"] =
        this.companyStreamState != null ? this.companyStreamState : false;
    return data;
  }
}
