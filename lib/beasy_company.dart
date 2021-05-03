import 'package:beasy_company/pages/add_stream_page.dart';
import 'package:beasy_company/pages/creating_company_screen.dart';
import 'package:beasy_company/pages/home_screen.dart';
import 'package:beasy_company/pages/onBoard.dart';
import 'package:beasy_company/pages/sign_in_screen.dart';
import 'package:beasy_company/pages/sign_up_screen.dart';
import 'package:beasy_company/utils/global_keys.dart';
import 'package:flutter/material.dart';

class BeasyCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: OnBoard.routeName,
      routes: {
        OnBoard.routeName: (c) => OnBoard(),
        SignInScreen.routeName: (c) => SignInScreen(),
        SignUpScreen.routeName: (c) => SignUpScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
        CreatingCompanyScreen.routeName: (c) => CreatingCompanyScreen(),
        AddStreamScreen.routeName: (c) => AddStreamScreen(),
      },
    );
  }
}
