import 'package:beasy_company/utils/enums.dart';
import 'package:beasy_company/utils/helpers.dart';

class User {
  String id;
  String name;
  String surname;
  String email;
  UserType userType;
  String companyId;
  String image;

  User({
    this.id,
    this.companyId,
    this.email,
    this.name,
    this.surname,
    this.userType,
    this.image,
  });

  factory User.fromJson(json) {
    return User(
      image: json["image"],
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      companyId: json["companyId"],
      id: json["id"],
      userType: userTypeFromString(json["userType"]),
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();

    data["name"] = this.name;
    data["surname"] = this.surname;
    data["email"] = this.email;
    data["companyId"] = this.companyId;
    data["id"] = this.id;
    data["image"] = this.image;
    data["userType"] = stringFromUserType(
      this.userType,
    );
    return data;
  }
}
