import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:meta/meta.dart';

part 'list_products_event.dart';
part 'list_products_state.dart';

class ListProductsBloc extends Bloc<ListProductsEvent, ListProductsState> {
  ListProductsBloc() : super(ListProductsInitial()) {
    on<FetchListProduct>((event, emit) async {
      emit(ListProductsIsLoading());
      final result = await ProductService().fetchListProducts();
      emit(result.fold((l) => ListProductsIsFailed(message: l),
          (r) => ListProductsIsSuccess(products: r)));
    });
  }
}
