import 'dart:async';
// import 'dart:js';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:management/services/localstorage_service.dart';
import 'package:meta/meta.dart';

import 'user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository? _userRepository;

  AuthBloc({@required UserRepository? userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository, super(Uninitialized());


  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event.context);
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final bool? isSignedIn = await _userRepository?.isSignedIn();
      if (isSignedIn==true) {
        final name = await _userRepository?.getUser();
        yield Authenticated(name!);
      } else {
        yield Unauthenticated(null);
      }
    } catch (_) {
      yield Unauthenticated(null);
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    GetIt.I<LocalStorageService>().hasLoggedIn= true;
    yield Authenticated(await _userRepository?.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState(BuildContext context) async* {
    yield Unauthenticated(context);
    _userRepository?.signOut();
  }
}
