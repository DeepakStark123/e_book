part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String successMsg;
  const AuthSuccessState({required this.successMsg});
  @override
  List<Object> get props => [successMsg];
}

final class AuthErrorState extends AuthState {
  final String errorMsg;
  const AuthErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
