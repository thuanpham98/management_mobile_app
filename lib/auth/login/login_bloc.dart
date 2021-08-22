import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../service_locator.dart';
import 'login.dart';
import '../../blocs/auth/user_repository.dart';
import '../validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository? _userRepository;

  LoginBloc({
    @required UserRepository? userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(LoginState.empty());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email!);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password!);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email!,
        password: event.password!,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield LoginState.loading();
      await _userRepository?.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      String errMsg = 'Unknow';
      log?.e('Error ${e.toString()}');
      yield LoginState.failure(errMsg);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String? email,
    String? password,
  }) async* {
    yield LoginState.loading();
    try {
      await _userRepository?.signInWithCredentials(email!, password);
      yield LoginState.success();
    } catch (e) {
      String errMsg = 'Unknow';
      log?.e('Error ${e.toString()}');
      if (e is PlatformException) {
        errMsg = e.message!;
      }
      yield LoginState.failure(errMsg);
    }
  }
}
