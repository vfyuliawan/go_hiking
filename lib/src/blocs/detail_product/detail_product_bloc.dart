import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:meta/meta.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc() : super(DetailProductInitial()) {
    on<DetailProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchDetailProduct>(
      (event, emit) async {
        emit(DetailProductIsLoading());
        final result = await ProductService().fetchDetailProduct(event.docId);
        emit(
          result.fold(
            (l) => DetailProductIsFailed(message: l),
            (r) => DetailProductIsSuccess(data: r),
          ),
        );
      },
    );
  }
}
