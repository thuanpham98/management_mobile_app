import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.i18n.dart';
class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(

      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      child: Text(
        'Sign in with Google'.i18n,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 0.4,
      fillColor: Color.fromRGBO(251, 136, 50, 1),
      // Colors.redAccent,
      padding: const EdgeInsets.all(15.0),
      hoverColor: Color.fromRGBO(255, 185, 98, 1),
    );
  }
}
