import 'package:flutter/material.dart';

class CircularPercentageIndicator extends StatelessWidget {
  final double value;
  final double size;
  final double strokeWidth;

  const CircularPercentageIndicator(
      {Key key, @required this.value, @required this.size, this.strokeWidth = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.size,
        height: this.size,
        child: Stack(children: <Widget>[
          SizedBox(
              width: this.size,
              height: this.size,
              child: CircularProgressIndicator(
                  strokeWidth: this.strokeWidth,
                  value: this.value,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor))),
          Container(
              alignment: Alignment.center,
              child: Text(
                '${(this.value * 100).toInt()}%',
                style: TextStyle(fontSize: this.size / 4),
              ))
        ]));
  }
}
