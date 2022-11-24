import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/services.dart';
import '../../utilities/utilities.dart';

part 'get_cart_count_state.dart';

class GetCartCountCubit extends Cubit<GetCartCountState> {
  GetCartCountCubit() : super(GetCartCountInitial());

  void getCartCount() async {
    emit(GetCartCountIsLoading());
    final result = await ProductService().getCartCount();
    emit(
      result.fold(
        (l) => GetCartCountIsFailed(message: l),
        (r) => GetCartCountIsSuccess(cartCount: r),
      ),
    );
  }
}
