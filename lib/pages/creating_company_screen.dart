import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_company/models/company_model/company.dart';
import 'package:beasy_company/pages/add_stream_page.dart';
import 'package:beasy_company/utils/helpers.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:beasy_company/widgets/inputs.dart';
import 'package:beasy_company/widgets/picking_item.dart';
import 'package:beasy_company/widgets/work_day_item.dart';
import 'package:flutter/material.dart';

class CreatingCompanyScreen extends StatefulWidget {
  static final routeName = "CreatingCompanyScreen";

  @override
  _CreatingCompanyScreenState createState() => _CreatingCompanyScreenState();
}

class _CreatingCompanyScreenState extends State<CreatingCompanyScreen> {
  String userImage = dummyProfileImg;
  String workDayStart = "Work day start.";
  String workDayEnd = "Work day end.";

  String pickedEndTime = "";

  var company = Company();

  @override
  void initState() {
    company.workDays = [];
    company.companyCategories = [];
    company.companyStreams = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: formScaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                companyAdditionalInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget companyAdditionalInfo() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage(
              userImage,
            ),
            radius: 40,
          ),
          CustomFormInput(
            hint: "Company Name",
            validator: (v) => emptyValidator(v),
            onSaved: (v) => company.companyName = v,
          ),
          CustomFormInput(
            hint: "Company Adress",
            validator: (v) => emptyValidator(v),
            onSaved: (v) => company.copmanyAdress = v,
          ),
          CustomFormInput(
            hint: "Write an short description for your company",
            minLines: 4,
            maxLines: 4,
            validator: (v) => emptyValidator(v),
            onSaved: (v) => company.companyDescription = v,
          ),
          workDaysTimePickView(),
          workDaysPicker(),
          categoriesPicker(),
          streamsView(),
        ],
      );

  Widget workDaysTimePickView() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "Company work day start at",
                    style: midiumTextStyle(color: mainBtnColor),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: lightBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: mainBorderColor,
                      width: 1,
                    ),
                  ),
                  onPressed: () async {
                    var res = await pickTime(context: context);
                    setState(() {
                      workDayStart =
                          "${res.hour} : ${res.minute}" ?? workDayStart;
                    });
                  },
                  child: Text(workDayStart),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    "Company work day end at",
                    style: midiumTextStyle(color: mainBtnColor),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  color: lightBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: mainBorderColor,
                      width: 1,
                    ),
                  ),
                  onPressed: () async {
                    var res = await pickTime(context: context);
                    setState(() {
                      workDayStart =
                          "${res.hour} : ${res.minute}" ?? workDayEnd;
                    });
                  },
                  child: Text(workDayEnd),
                ),
              ],
            ),
          ],
        ),
      );

  Widget workDaysPicker() => Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...workDays
                  .map(
                    (e) => WorkDayItem(
                      name: e.shorted,
                      initialValue: company.workDays.contains(e.shorted),
                      onClick: (v) {
                        if (v) {
                          company.workDays.add(e.shorted);
                        } else {
                          company.workDays.remove(e.shorted);
                        }
                      },
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      );

  Widget categoriesPicker() => Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Choose you company categories",
              style: midiumTextStyle(color: mainBtnColor),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  ...categories
                      .map(
                        (e) => PickingItem(
                          name: e.categoryName,
                          initialValue: company.companyCategories.contains(e),
                          onClick: (v) {
                            if (v) {
                              company.companyCategories.add(e);
                            } else {
                              company.companyCategories.remove(e);
                            }
                            print(company.companyCategories.length);
                          },
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        ),
      );

  Widget streamsView() => Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Your company streas,can be an worker of your company or an service place",
              style: midiumTextStyle(color: mainBtnColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () async {
                    var res = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (c) => AddStreamScreen(),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 1),
                  ),
                  child: Text(
                    "+Add Stream",
                    style: midiumTextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
