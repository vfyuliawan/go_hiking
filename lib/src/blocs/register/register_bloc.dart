import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:go_hiking/src/utilities/utilities.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      // TODO: implement event handler
      emit(RegisterIsLoading());
      final result = await UserService().registerWithEmail(
          email: event.email, name: event.username, password: event.password);
      //fold akan melempar kiri dan kanan L or Right
      //kiri jika true dan kanan jika right
      emit(result.fold((l) => RegisterIsFailde(message: l), (r) {
        Commons().setUid(r.uid!);
        return RegisterIsSuccsess(data: r);
      }));
    });
  }
}
