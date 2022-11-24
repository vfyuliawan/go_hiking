import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_hiking/src/blocs/bloc.dart';
import 'package:go_hiking/src/cubits/get_cart_count/get_cart_count_cubit.dart';
import 'package:go_hiking/src/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../blocs/detail_product/detail_product_bloc.dart';

part 'router.dart';
part 'colors.dart';
part 'constanta.dart';
part 'commons.dart';
