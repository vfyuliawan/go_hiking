import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:meta/meta.dart';

part 'remove_cart_state.dart';

class RemoveCartCubit extends Cubit<RemoveCartState> {
  RemoveCartCubit() : super(RemoveCartInitial());

  void removeCart(String productId) async {
    emit(RemoveCartIsLoading());
    final result = await ProductService().removeCartCount(productId);
    emit(
      result.fold(
        (l) => RemoveCartIsFailed(message: l),
        (r) => RemoveCartIsSuccess(message: r),
      ),
    );
  }
}
