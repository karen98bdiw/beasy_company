import 'package:beasy_company/pages/home_screen.dart';
import 'package:beasy_company/services/beasyApi.dart';
import 'package:beasy_company/services/service_constats.dart';
import 'package:beasy_company/utils/enums.dart';
import 'package:beasy_company/utils/helpers.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:beasy_company/widgets/buttons.dart';
import 'package:beasy_company/widgets/helpers.dart';
import 'package:beasy_company/widgets/inputPrefixes.dart';
import 'package:beasy_company/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SignInScreen extends StatefulWidget {
  static final routeName = "SignInScreen";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email;

  String password;

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();

  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  void _onSignIn() async {
    if (!_formState.currentState.validate()) return;
    _formState.currentState.save();
    showLoading();
    var res = await BeasyApi().userServices.signIn(
          email: email,
          password: password,
        );
    hideLoading();
    if (res.errorText == null) {
      _formState.currentState.reset();
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } else {
      await showError(errorText: userNotExist, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
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
                      "Sign In",
                      style: titleStyle(isLight: false),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    signInForm(),
                    SizedBox(
                      height: 10,
                    ),
                    action(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget action() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomBtn(
            title: "Sign In",
            onClick: _onSignIn,
          ),
          SizedBox(
            height: 10,
          ),
          loginActionChange(toAction: LoginAction.SignUp, context: context),
        ],
      );

  Widget signInForm() => Form(
      key: _formState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormInput(
            prefix: userPrefix,
            focuseNode: _emailNode,
            inputAction: TextInputAction.next,
            onEditingComplate: () {
              _passwordNode.requestFocus();
            },
            hint: "E-Mail",
            validator: (v) => emailValidator(v),
            onSaved: (v) => email = v,
          ),
          CustomFormInput(
            prefix: passwordPrefix,
            sufix: GestureDetector(
              onTap: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              child: passwordSufix,
            ),
            focuseNode: _passwordNode,
            onEditingComplate: _onSignIn,
            inputAction: TextInputAction.done,
            obscureText: obscurePassword,
            hint: "Password",
            onSaved: (v) => password = v,
            validator: (v) => passwordValidator(v),
          ),
        ],
      ));
}
