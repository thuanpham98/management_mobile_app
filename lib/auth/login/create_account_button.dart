import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../services/navigation_service.dart';

class CreateAccountButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        GetIt.I<NavigationService>().navTo('/register', context: context);
      },
    );
  }
}
