import 'package:flutter/material.dart';

Widget defaultBtn(BuildContext context, String text, {Color color}) {
  return Container(
    width: 160,
    padding: EdgeInsets.symmetric(vertical: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black38,
              offset: Offset(2, 4),
              blurRadius: 8,
              spreadRadius: 2)
        ],
        color: color == null ? Theme.of(context).primaryColor : color),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 17.8,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
