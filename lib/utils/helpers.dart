import 'package:beasy_company/utils/enums.dart';
import 'package:flutter/material.dart';

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

  return DateTime(
      curent.year, curent.month, curent.day, timeOfDay.hour, timeOfDay.minute);
}
