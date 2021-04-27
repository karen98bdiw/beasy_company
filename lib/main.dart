import 'package:beasy_company/beasy_company.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BeasyCompany());
}

Future<void> main(List<String> args) async {
  await run();
}
