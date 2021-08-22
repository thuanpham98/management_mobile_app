import 'package:flutter/material.dart';

class FarmForm extends StatefulWidget {
  FarmForm({Key? key}) : super(key: key);

  @override
  _FarmFormState createState() => _FarmFormState();
}

class _FarmFormState extends State<FarmForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5.0),
        height: MediaQuery.of(context).size.height - 50,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Text('Farm form'),
          ),
        ));
    ;
  }
}
