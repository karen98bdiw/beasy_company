import 'package:beasy_company/models/user_models/user.dart';
import 'package:beasy_company/pages/creating_company_screen.dart';
import 'package:beasy_company/services/beasyApi.dart';
import 'package:beasy_company/utils/helpers.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:beasy_company/widgets/buttons.dart';
import 'package:beasy_company/widgets/helpers.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User curentUser = BeasyApi().userServices.curentUser;

  @override
  void initState() {
    curentUser = BeasyApi().userServices.curentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var res = await confirmLogOut(context: context);
        return res;
      },
      child: Scaffold(
        backgroundColor: lightBackground,
        body: LayoutBuilder(
          builder: (c, cn) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: cn.maxWidth,
                minHeight: cn.maxHeight,
              ),
              child: Padding(
                padding: formScaffoldPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userInfoView(),
                    SizedBox(
                      height: 20,
                    ),
                    curentUser.companyId == null
                        ? viewBeforeCompanyCreation()
                        : viewAfterCompanyCreation(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userInfoView() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: iconColor,
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  onPressed: () {},
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage:
                    NetworkImage(curentUser.image ?? dummyProfileImg),
              ),
              CircleAvatar(
                backgroundColor: iconColor,
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            curentUser.name + " " + curentUser.surname,
            style: largeTextStyle(),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            curentUser.email,
            style: midiumTextStyle(color: mainBtnColor),
          ),
        ],
      );

  Widget viewBeforeCompanyCreation() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "You dont have company yet!",
            style: midiumTextStyle(color: mainBtnColor),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "You can create your company reference with Beasy in couple of minute, after this you will able to use all our features,manage your buisnes company queue,make your workers account and let all users to know about you!",
              style: smallTextStyle(color: mainButtonColor),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Need some help ?",
                style: midiumTextStyle(
                  color: lightBlue,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomBtn(
                title: "Create Company",
                onClick: () {
                  Navigator.of(context)
                      .pushNamed(CreatingCompanyScreen.routeName);
                },
              ),
            ],
          ),
        ],
      );
  Widget viewAfterCompanyCreation() => Text("have company");
}
