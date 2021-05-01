import 'package:beasy_company/models/user_models/user.dart';
import 'package:beasy_company/pages/home_screen.dart';
import 'package:beasy_company/services/beasyApi.dart';
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

class SignUpScreen extends StatefulWidget {
  static final routeName = "SignUpScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final user = User(userType: UserType.CompanyOwner);

  String password;

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final FocusNode nameNode = FocusNode();
  final FocusNode surnameNode = FocusNode();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode repeatNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;

  @override
  void dispose() {
    nameNode.dispose();
    surnameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    repeatNode.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() async {
    if (!_formState.currentState.validate()) return;
    _formState.currentState.save();
    showLoading();
    var res = await BeasyApi()
        .userServices
        .createUser(user: user, password: password);
    hideLoading();
    if (res.errorText == null) {
      passwordController.clear();
      _formState.currentState.reset();
      passwordController.clear();

      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } else {
      showError(errorText: res.errorText, context: context);
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
            title: "Sign Up",
            onClick: _onSignUp,
          ),
          SizedBox(
            height: 10,
          ),
          loginActionChange(toAction: LoginAction.SignIn, context: context),
        ],
      );

  Widget signInForm() => Form(
      key: _formState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormInput(
            prefix: userPrefix,
            onEditingComplate: () {
              surnameNode.requestFocus();
            },
            inputAction: TextInputAction.next,
            hint: "Name",
            validator: (v) => v.isEmpty ? "Nick Name is required" : null,
            onSaved: (v) => user.name = v,
          ),
          CustomFormInput(
            focuseNode: surnameNode,
            prefix: userPrefix,
            onEditingComplate: () {
              emailNode.requestFocus();
            },
            inputAction: TextInputAction.next,
            hint: "Surname",
            validator: (v) => v.isEmpty ? "Surname is required" : null,
            onSaved: (v) => user.surname = v,
          ),
          CustomFormInput(
            prefix: emailPrefix,
            focuseNode: emailNode,
            inputAction: TextInputAction.next,
            onEditingComplate: () {
              passwordNode.requestFocus();
            },
            hint: "E-Mail",
            validator: (v) => emailValidator(v),
            onSaved: (v) => user.email = v,
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
            controller: passwordController,
            inputAction: TextInputAction.next,
            focuseNode: passwordNode,
            onEditingComplate: () {
              repeatNode.requestFocus();
            },
            obscureText: true,
            hint: "Password",
            onSaved: (v) => password = v,
            validator: (v) => passwordValidator(v),
          ),
          CustomFormInput(
            sufix: GestureDetector(
              onTap: () {
                setState(() {
                  obscureRepeatPassword = !obscureRepeatPassword;
                });
              },
              child: passwordSufix,
            ),
            prefix: passwordPrefix,
            inputAction: TextInputAction.done,
            focuseNode: repeatNode,
            onEditingComplate: _onSignUp,
            obscureText: true,
            hint: "Repeat password",
            onSaved: (v) => password = v,
            validator: (v) => v == passwordController.text
                ? passwordValidator(v)
                : "Password did't match",
          ),
        ],
      ));
}
