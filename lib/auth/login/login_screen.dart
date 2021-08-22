import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service_locator.dart';
import '../../blocs/auth/user_repository.dart';
import 'login_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(userRepository: locator<UserRepository>()),
        child: LoginForm(),
      ),
    );
  }
}
