import 'package:beasy_company/pages/home_screen.dart';
import 'package:beasy_company/pages/sign_in_screen.dart';
import 'package:beasy_company/pages/sign_up_screen.dart';
import 'package:beasy_company/services/beasyApi.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:beasy_company/widgets/buttons.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoard extends StatefulWidget {
  static final routeName = "OnBoard";

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  void initState() {
    checkIfUserSigned();
    super.initState();
  }

  void checkIfUserSigned() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // showLoading(context: context);
      await BeasyApi()
          .userServices
          .setCurentUser(userId: FirebaseAuth.instance.currentUser.uid);
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: lightBackground,
        padding: formScaffoldPadding,
        child: LayoutBuilder(
          builder: (c, cn) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: cn.maxHeight,
                minWidth: cn.maxWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Beasy Company",
                    style: titleStyle(isLight: false),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    "assets/images/googlePlusIcon.svg",
                    width: MediaQuery.of(context).size.height * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: mainBtnColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  actions(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget actions(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBtn(
            title: "Sign In",
            onClick: () {
              Navigator.of(context).pushNamed(SignInScreen.routeName);
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomBtn(
            outlined: true,
            outlineColor: Colors.black,
            textColor: mainBtnColor,
            title: "Sign Up",
            onClick: () {
              Navigator.of(context).pushNamed(SignUpScreen.routeName);
            },
          ),
        ],
      );
}
