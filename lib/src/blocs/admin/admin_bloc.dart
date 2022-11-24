import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/cubits/cubits.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  //throw product picture cubit ke AdminBloc
  final ProductPictureCubit productPictureCubit;
  AdminBloc(this.productPictureCubit) : super(AdminInitial()) {
    on<AddProduct>((event, emit) async {
      // TODO: implement event handler
      emit(AdminIsLoading());
      ProductModel data = ProductModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          dateTime: DateTime.now(),
          name: event.name,
          price: event.price,
          desc: event.desc);

      final result = await AdminService().addNewProduct(data,
          file: (productPictureCubit.state is ProductPictureIsLoaded)
              ? (productPictureCubit.state as ProductPictureIsLoaded).file
              : null);

      result.fold(
        (l) => emit(AdminIsFailed(message: l)),
        (r) => emit(
          AdminIsSuccess(message: r),
        ),
      );
    });
  }
}
