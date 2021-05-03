import 'dart:io';

import 'package:beasy_company/models/company_model/company_stream.dart';
import 'package:beasy_company/utils/helpers.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:beasy_company/widgets/inputs.dart';
import 'package:flutter/material.dart';

class AddStreamScreen extends StatefulWidget {
  static final routeName = "AddStreamScreen";
  @override
  _AddStreamScreenState createState() => _AddStreamScreenState();
}

class _AddStreamScreenState extends State<AddStreamScreen> {
  String avatarImage = dummyProfileImg;
  File pickedAvatar;

  var stream = CompanyStream();
  List<File> imagesFiles = [];

  @override
  void initState() {
    stream.streamImages = [];
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
                avatar(),
                _form(),
                pickedImages(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pickedImages() => Container(
        padding: EdgeInsets.all(8),
        height: stream.streamImages.length == 0 ? 100 : 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            stream.streamImages.length != 0
                ? Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (c, i) => SizedBox(
                        width: 10,
                      ),
                      itemBuilder: (c, i) => Container(
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Image.file(
                                File(
                                  stream.streamImages[i],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      stream.streamImages.removeAt(i);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      itemCount: stream.streamImages.length,
                    ),
                  )
                : Text(
                    "Add images to your stream",
                    style: midiumTextStyle(
                      color: mainBtnColor,
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () async {
                    var res = await pickImages();
                    setState(() {
                      res.forEach((element) {
                        stream.streamImages.add(element.path);
                      });
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(width: 1),
                  ),
                  child: Text(
                    "+Add Images",
                    style: midiumTextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _form() => Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CustomFormInput(
              validator: (v) => emptyValidator(v),
              onSaved: (v) => stream.streamName = v,
              hint: "Stream name",
            ),
            CustomFormInput(
              validator: (v) => emptyValidator(v),
              onSaved: (v) => stream.streamDescription = v,
              hint: "Stream description",
              maxLines: 3,
              minLines: 3,
            ),
          ],
        ),
      );

  Widget avatar() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 3,
                    color: mainBtnColor,
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: pickedAvatar != null
                      ? FileImage(pickedAvatar)
                      : NetworkImage(
                          avatarImage,
                        ),
                ),
              ),
              Positioned(
                right: -5,
                top: -5,
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      pickedAvatar = null;
                    });
                  },
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -5,
                bottom: -5,
                child: IconButton(
                  onPressed: () async {
                    var res = await pickImage();
                    if (res != null) {
                      setState(() {
                        pickedAvatar = res;
                        stream.avatar = pickedAvatar.path;
                      });
                    }
                  },
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );

  Widget imagesView() => Container(
        height: 400,
        child: ListView.builder(
          itemBuilder: (c, i) => Container(
            width: 200,
            height: 200,
            child: Stack(
              children: [
                Image.file(
                  imagesFiles[i],
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
          itemCount: imagesFiles.length,
        ),
      );
}
