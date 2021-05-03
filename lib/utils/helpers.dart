import 'dart:io';

import 'package:beasy_company/models/company_model/company_category.dart';
import 'package:beasy_company/models/utils/workDay.dart';
import 'package:beasy_company/utils/enums.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

UserType userTypeFromString(String typeString) {
  switch (typeString) {
    case "Company Owner":
      return UserType.CompanyOwner;
      break;
    case "Usual User":
      return UserType.UsualUser;
      break;
  }
  return null;
}

String stringFromUserType(UserType type) {
  switch (type) {
    case UserType.CompanyOwner:
      return "Company Owner";
      break;
    case UserType.UsualUser:
      return "Usual User";
      break;
  }

  return null;
}

bool isValidEmail(String email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

DateTime timeOfDaytoDate(TimeOfDay timeOfDay) {
  var curent = DateTime.now();

  return timeOfDay != null
      ? DateTime(curent.year, curent.month, curent.day, timeOfDay.hour,
          timeOfDay.minute)
      : null;
}

var dummyUserImage =
    "https://library.kissclipart.com/20180901/krw/kissclipart-user-thumbnail-clipart-user-lorem-ipsum-is-simply-bfcb758bf53bea22.jpg";
var dummyProfileImg =
    "https://suryahospitals.com/jaipur/wp-content/uploads/sites/3/2020/07/dummy-user.jpg";

dynamic emailValidator(String value) {
  return value.isEmpty || !isValidEmail(value) ? "Invalid E-Main" : null;
}

dynamic passwordValidator(String value) {
  return value.isEmpty || value.length < 6
      ? "Password must contains at last 6 symbols"
      : null;
}

dynamic emptyValidator(String value) {
  return value.isEmpty ? "Field is required!" : null;
}

Future<DateTime> pickTime({BuildContext context}) async {
  var res = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now(),
      ));
  return timeOfDaytoDate(res);
}

Future<File> pickImage() async {
  var res = await FilePicker.getFilePath(
    allowedExtensions: ["jpg", "png", "jpeg"],
    type: FileType.custom,
  );
  return res != null ? File(res) : null;
}

Future<List<File>> pickImages() async {
  var res = await FilePicker.getMultiFilePath(
    allowedExtensions: ["jpg", "png", "jpeg"],
    type: FileType.custom,
  );
  return res != null ? res.values.map((e) => File(e)).toList() : null;
}

var workDays = [
  WorkDay(name: "Monday", shorted: "Mon"),
  WorkDay(name: "Tuesday", shorted: "Tue"),
  WorkDay(name: "Wednesday", shorted: "Wed"),
  WorkDay(name: "Thursday", shorted: "Thu"),
  WorkDay(name: "Friday", shorted: "Fri"),
  WorkDay(name: "Saturday", shorted: "Sat"),
  WorkDay(name: "Sunday", shorted: "Sun"),
];

var categories = [
  CompanyCategory(
    companyCategoryId: "0",
    categoryName: "Sport",
  ),
  CompanyCategory(
    companyCategoryId: "1",
    categoryName: "Health",
  ),
  CompanyCategory(
    companyCategoryId: "0",
    categoryName: "Shop",
  ),
  CompanyCategory(
    companyCategoryId: "0",
    categoryName: "Cars",
  ),
  CompanyCategory(
    companyCategoryId: "0",
    categoryName: "Tourism",
  ),
  CompanyCategory(
    companyCategoryId: "0",
    categoryName: "Service",
  ),
];
