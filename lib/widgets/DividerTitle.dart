import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DividerTitle extends StatelessWidget {
  final String title;
  final double titleSpacing;

  DividerTitle({this.title, this.titleSpacing = 20.0});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
                margin: EdgeInsets.only(left: 10.0, right: titleSpacing),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
          Text(title),
          Expanded(
            flex: 1,
            child: new Container(
                margin: EdgeInsets.only(left: titleSpacing, right: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 36,
                )),
          ),
        ]);
  }
}
