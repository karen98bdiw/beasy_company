import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_company/pages/sign_in_screen.dart';
import 'package:beasy_company/pages/sign_up_screen.dart';
import 'package:beasy_company/services/beasyApi.dart';
import 'package:beasy_company/utils/enums.dart';
import 'package:beasy_company/utils/global_keys.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:beasy_company/widgets/buttons.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormScreenTitle extends StatelessWidget {
  final String title;

  FormScreenTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: titleColor,
      ),
    );
  }
}

class RegisterScreenNumbers extends StatelessWidget {
  final int number;

  RegisterScreenNumbers(this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          numberView(index: 0, curentNumber: number, title: "Detailis"),
          SizedBox(
            width: 10,
          ),
          numberView(index: 1, curentNumber: number, title: "Information")
        ],
      ),
    );
  }

  Widget numberView({int index, String title, int curentNumber}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: index == curentNumber ? lightBlue : Colors.transparent,
                border: index != curentNumber
                    ? Border.all(width: 1, color: greyShape)
                    : null),
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: mediumTextStyle(
                    color: index == curentNumber ? Colors.white : greyShape),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
              color: index == curentNumber ? lightBlue : greyShape,
            ),
          ),
        ],
      );
}

class TitledCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged onChanged;
  final String title;
  final bool showTitle;

  TitledCheckBox({
    this.value,
    this.onChanged,
    this.title,
    this.showTitle = true,
  });

  @override
  _TitledCheckBoxState createState() => _TitledCheckBoxState();
}

class _TitledCheckBoxState extends State<TitledCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(color: mainBorderColor, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: widget.value
                ? Center(
                    child: SvgPicture.asset("assets/icons/doneIcon.svg"),
                  )
                : Container(),
          ),
          SizedBox(
            width: 8,
          ),
          widget.showTitle
              ? Expanded(
                  // width: MediaQuery.of(context).size.width * 0.35,

                  child: AutoSizeText(
                    widget.title ?? "",
                    style: mediumTextStyle(),
                    maxLines: 1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class RoundedCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged onChanged;
  final String title;
  final bool showTitle;

  RoundedCheckBox({
    this.value,
    this.onChanged,
    this.title,
    this.showTitle = false,
  });

  @override
  _RoundedCheckBoxState createState() => _RoundedCheckBoxState();
}

class _RoundedCheckBoxState extends State<RoundedCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border: Border.all(color: mainBorderColor, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: widget.value
                ? Center(
                    child: SvgPicture.asset("assets/icons/doneIcon.svg"),
                  )
                : Container(),
          ),
          SizedBox(
            width: 8,
          ),
          widget.showTitle
              ? Expanded(
                  // width: MediaQuery.of(context).size.width * 0.35,

                  child: AutoSizeText(
                    widget.title ?? "",
                    style: mediumTextStyle(),
                    maxLines: 1,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class TitledRadioButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;

  TitledRadioButton({this.value, this.onChanged, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 17,
              height: 17,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: mainBorderColor),
              ),
              child: Center(
                child: Container(
                  width: 13,
                  height: 13,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? lightBlue : Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title ?? "",
              style: mediumTextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

Widget loginActionChange({LoginAction toAction, BuildContext context}) =>
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            text: toAction == LoginAction.SignIn
                ? "Already have account?  "
                : "Don'n have account yet?  ",
          ),
          WidgetSpan(
              child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                toAction == LoginAction.SignIn
                    ? SignInScreen.routeName
                    : SignUpScreen.routeName),
            child: Text(
              toAction == LoginAction.SignIn ? "Sign In" : "Sign Up",
              style: TextStyle(
                  color: lightBlue,
                  decoration: TextDecoration.underline,
                  fontSize: 20),
            ),
          )),
        ],
      ),
    );

showError({String errorText, String title, BuildContext context}) async {
  await showDialog(
    context: context,
    builder: (c) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title ?? "Error",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  errorText ?? "",
                  maxFontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

showLoading({BuildContext context}) async {
  await showDialog(
    barrierDismissible: false,
    context: context ?? navigatorKey.currentContext,
    builder: (c) => Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(
              navigatorKey.currentContext,
            ).size.width *
            0.2,
        height: MediaQuery.of(
              navigatorKey.currentContext,
            ).size.height *
            0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              backgroundColor: darkBackground,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "loading...",
              style: TextStyle(
                color: darkBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

hideLoading({BuildContext context}) {
  if (context != null) {
    Navigator.of(context).pop();
  } else {
    navigatorKey.currentState.pop();
  }
}

Future<bool> exitFromAppConfirmation(BuildContext context) async {
  var res = await showDialog(
    context: context,
    builder: (c) => Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Looks like you want to exit app?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomBtn(
                      title: "No",
                      onClick: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomBtn(
                      title: "Yes",
                      onClick: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );

  return res ?? false;
}

Future<bool> confirmLogOut({BuildContext context}) async {
  var res = await showDialog(
    context: context,
    builder: (c) => Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Looks like you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomBtn(
                      title: "No",
                      onClick: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomBtn(
                      title: "Yes",
                      onClick: () async {
                        await BeasyApi().userServices.logOut();
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );

  return res ?? false;
}
