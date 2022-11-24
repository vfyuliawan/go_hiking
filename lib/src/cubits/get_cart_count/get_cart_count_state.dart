// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_cart_count_cubit.dart';

@immutable
abstract class GetCartCountState {}

class GetCartCountInitial extends GetCartCountState {}

class GetCartCountIsLoading extends GetCartCountState {}

class GetCartCountIsFailed extends GetCartCountState {
  final String message;
  GetCartCountIsFailed({
    required this.message,
  });
}

class GetCartCountIsSuccess extends GetCartCountState {
  final int cartCount;
  GetCartCountIsSuccess({
    required this.cartCount,
  });
}
