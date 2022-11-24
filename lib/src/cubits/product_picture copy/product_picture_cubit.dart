import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:go_hiking/src/utilities/utilities.dart';
import 'package:meta/meta.dart';

import '../cubits.dart';

part 'product_picture_state.dart';

class ProductPictureCubit extends Cubit<ProductPictureState> {
  ProductPictureCubit() : super(ProductPictureInitial());

  //TODO : Buat function getImage
  void getImage() async {
    final file = await Commons().getImage();
    //cek file yang dipilih
    if (file.path.isNotEmpty) {
      emit(ProductPictureIsLoaded(file: file));
    } else {
      emit(ProductPictureIsFailed());
    }
  }

  void resetImage() async {
    emit(ProductPictureInitial());
  }
}
