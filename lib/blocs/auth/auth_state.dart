import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  final String? displayName;

  const Authenticated(this.displayName);

  @override
  List<Object?> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class Unauthenticated extends AuthState {
  final BuildContext? context;

  Unauthenticated(this.context);
}
