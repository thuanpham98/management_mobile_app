import 'package:flutter/material.dart';

import '../progress_container.dart';

class Controller extends StatefulWidget {
  Controller({Key? key}) : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ProgressContainer(
          strokeWidth: 2,
          color: Theme.of(context).errorColor,
          rounded: 10,
          percentage: 10,
          child: Container(
            decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                border: Border.all(width: 0.1),
                borderRadius: BorderRadius.all(
                    Radius.circular(10) //         <--- border radius here
                    )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: ElevatedButton(onPressed: (){},child: Container(),), flex: 2),
                Expanded(child: ElevatedButton(onPressed: (){},child: Container(),), flex: 1),
              ],
            ),
          )),
    );
  }
}
