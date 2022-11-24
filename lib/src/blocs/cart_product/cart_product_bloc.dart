import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:meta/meta.dart';

part 'cart_product_event.dart';
part 'cart_product_state.dart';

class CartProductBloc extends Bloc<CartProductEvent, CartProductState> {
  CartProductBloc() : super(CartProductInitial()) {
    on<FetchListCart>((event, emit) async {
      emit(CartProductIsLoading());
      final result = await ProductService().fetchListCart();
      emit(result.fold((l) => CartProductIsFailed(message: l),
          (r) => CartProductIsSuccess(model: r)));
    });
  }
}
