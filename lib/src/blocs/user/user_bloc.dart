// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:go_hiking/src/models/models.dart';
import 'package:go_hiking/src/services/services.dart';
import 'package:go_hiking/src/utilities/utilities.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserIsLoading());
      String? uid = await Commons().getUid();
      final result = await UserService().loadUserData(uid);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) => UserIsSuccess(data: r),
        ),
      );
    });

    on<LogOutUser>((event, emit) async {
      UserService().logOutUser();
      await Commons().removeUid();
      emit(UserIsLogOut());
    });
  }
}
