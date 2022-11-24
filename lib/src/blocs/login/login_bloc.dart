import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:go_hiking/src/utilities/utilities.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginIsLoading());
      final result = await UserService()
          .loginWithEmail(email: event.email, password: event.password);
      emit(
        result.fold(
          (l) => LoginIsFailed(message: l),
          (r) {
            Commons().setUid(r.uid!);
            return LoginIsSuccess();
          },
        ),
      );
    });
  }
}
