import 'package:auto_size_text/auto_size_text.dart';
import 'package:beasy_company/utils/style_color.dart';
import 'package:beasy_company/utils/styles.dart';
import 'package:flutter/material.dart';

class PickingItem extends StatefulWidget {
  final String name;
  final ValueChanged<bool> onClick;
  final bool initialValue;

  PickingItem({this.initialValue = false, this.name, this.onClick});
  @override
  _PickingItemState createState() => _PickingItemState();
}

class _PickingItemState extends State<PickingItem> {
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
        constraints: BoxConstraints(
          maxWidth: 60,
          maxHeight: 40,
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: clicked ? lightBlue : mainBtnColor,
        ),
        child: Center(
          child: AutoSizeText(
            widget.name,
            maxLines: 1,
            style: midiumTextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
