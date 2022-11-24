// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_to_chart_cubit.dart';

@immutable
abstract class AddToChartState {}

class AddToChartInitial extends AddToChartState {}

class AddToChartIsLoading extends AddToChartState {}

class AddToChartIsSuccsess extends AddToChartState {
  final String messag;
  AddToChartIsSuccsess({
    required this.messag,
  });
}

class AddToChartIsFailed extends AddToChartState {
  final String message;
  AddToChartIsFailed({
    required this.message,
  });
}
