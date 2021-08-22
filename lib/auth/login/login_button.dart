import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  LoginButton({Key? key, VoidCallback? onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: _onPressed,
      child: Text(
        'Login',
        style: TextStyle(color: Theme.of(context).primaryColorLight),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0.4,
      fillColor: Theme.of(context).buttonColor,
      padding: const EdgeInsets.all(15.0),
    );
  }
}
