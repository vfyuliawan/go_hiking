import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_hiking/src/blocs/bloc.dart';
import 'package:go_hiking/src/blocs/detail_product/detail_product_bloc.dart';
import 'package:go_hiking/src/cubits/cubits.dart';
import 'package:go_hiking/src/cubits/product_picture/product_picture_cubit.dart';
import 'package:go_hiking/src/utilities/utilities.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => ProductPictureCubit(),
        ),
        BlocProvider(
          create: (context) =>
              AdminBloc(BlocProvider.of<ProductPictureCubit>(context)),
        ),
        BlocProvider(
          create: (context) => ListProductsBloc(),
        ),
        BlocProvider(
          create: (context) => DetailProductBloc(),
        ),
        BlocProvider(
          create: (context) => AddToChartCubit(),
        ),
        BlocProvider(
          create: (context) => CartProductBloc(),
        ),
        BlocProvider(
          create: (context) => GetCartCountCubit(),
        ),
        BlocProvider(
          create: (context) => RemoveCartCubit(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
