// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'remove_cart_cubit.dart';

@immutable
abstract class RemoveCartState {}

class RemoveCartInitial extends RemoveCartState {}

class RemoveCartIsLoading extends RemoveCartState {}

class RemoveCartIsSuccess extends RemoveCartState {
  final String message;
  RemoveCartIsSuccess({
    required this.message,
  });
}

class RemoveCartIsFailed extends RemoveCartState {
  final String message;
  RemoveCartIsFailed({
    required this.message,
  });
}
