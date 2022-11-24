// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_product_bloc.dart';

@immutable
abstract class CartProductState {}

class CartProductInitial extends CartProductState {}

class CartProductIsLoading extends CartProductState {}

class CartProductIsSuccess extends CartProductState {
  final List<ProductModel> model;
  CartProductIsSuccess({
    required this.model,
  });
}

class CartProductIsFailed extends CartProductState {
  final String message;
  CartProductIsFailed({
    required this.message,
  });
}
