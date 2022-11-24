// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_products_bloc.dart';

@immutable
abstract class ListProductsState {}

class ListProductsInitial extends ListProductsState {}

class ListProductsIsLoading extends ListProductsState {}

class ListProductsIsSuccess extends ListProductsState {
  final List<ProductModel> products;
  ListProductsIsSuccess({
    required this.products,
  });
}

class ListProductsIsFailed extends ListProductsState {
  final String message;
  ListProductsIsFailed({
    required this.message,
  });
}
