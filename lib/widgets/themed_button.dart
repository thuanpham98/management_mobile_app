import 'package:flutter/material.dart';

class ThemedButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;

  ThemedButton(this.text,
      {this.icon, this.padding, this.margin, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var container = Container(
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text.toString(),
                style: TextStyle(color: Theme.of(context).textSelectionColor),
              ),
              icon != null
                  ? Icon(
                      icon,
                      color: Theme.of(context).textSelectionColor,
                    )
                  : Container()
            ],
          ),
          onPressed: onPressed,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).focusColor,
        ),
        margin: margin,
        padding: padding ??
            const EdgeInsets.only(left: 4, top: 10, bottom: 10, right: 4));
    return container;
  }
}
