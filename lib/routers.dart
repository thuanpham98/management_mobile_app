import 'package:fluro/fluro.dart' as Fluro;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management/main_screen.dart';

import 'blocs/auth/user_repository.dart';
import 'service_locator.dart';
import 'blocs/auth/auth.dart';
import 'auth/login/login_screen.dart';

class Routes {
  static Fluro.Handler routing(Widget Function(Map<String, List<String>>) createPage,
      {bool? auth}) {
    return Fluro.Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
      return BlocProvider(
        create: (context) => AuthBloc(userRepository: locator<UserRepository>())
          ..add(AppStarted()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            bool needLogin = state is Unauthenticated && auth != null && auth;

            log?.v("state = $state - need login = $needLogin == $createPage");
            return needLogin ? LoginScreen() : createPage(params!);
          },
        ),
      );
    });
  }

  static void init(Fluro.FluroRouter router) {
    router.define("/", handler: routing((params) => MainScreen(), auth: true));
    router.define("/login", handler: routing((params) => LoginScreen()));
  }
}
