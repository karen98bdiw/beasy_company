import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:flutter/material.dart';

class WorkDayItem extends StatefulWidget {
  final String name;
  final ValueChanged<bool> onClick;
  final bool initialValue;

  WorkDayItem({this.name, this.onClick, this.initialValue = false});

  @override
  _WorkDayItemState createState() => _WorkDayItemState();
}

class _WorkDayItemState extends State<WorkDayItem> {
  var clicked;

  @override
  void initState() {
    clicked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          clicked = !clicked;
          widget.onClick(clicked);
        });
      },
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: clicked ? lightBlue : mainBtnColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AutoSizeText(
            widget.name,
            style: midiumTextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
