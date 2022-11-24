// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterIsLoading extends RegisterState {}

class RegisterIsFailde extends RegisterState {
  final String message;
  RegisterIsFailde({
    required this.message,
  });
}

class RegisterIsSuccsess extends RegisterState {
  final UserModel data;
  RegisterIsSuccsess({
    required this.data,
  });
}
