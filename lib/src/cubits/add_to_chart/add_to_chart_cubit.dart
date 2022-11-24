// ignore_for_file: depend_on_referenced_packages, duplicate_ignore

import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/models/models.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../services/services.dart';

part 'add_to_chart_state.dart';

class AddToChartCubit extends Cubit<AddToChartState> {
  AddToChartCubit() : super(AddToChartInitial());

  void addToChart(ProductModel model) async {
    emit(AddToChartIsLoading());

    final result = await ProductService().addToCart(model);
    emit(result.fold((l) => AddToChartIsFailed(message: l),
        (r) => AddToChartIsSuccsess(messag: r)));
  }
}
