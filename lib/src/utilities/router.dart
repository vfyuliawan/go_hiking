part of 'utilities.dart';

mixin routeName {
  static const login = '/login';
  static const splash = '/splash';
  static const register = '/register';
  static const home = '/home';
  static const admin = 'admin';
  static const adminPath = '/home/admin';
  static const detail = 'detailProduct';
  static const detailPath = '/home/detailProduct';
  static const cart = 'cart';
  static const cartPath = '/home/cart';
}

final GoRouter router = GoRouter(
    //saat app pertama kali kebuka
    initialLocation: routeName.splash,
    // redirect: (context, state) {
    //   return routeName.register;
    // },
    routes: [
      GoRoute(
        path: routeName.splash,
        redirect: (context, state) {
          if (FirebaseAuth.instance.currentUser != null) {
            // Commons().setUid(FirebaseAuth.instance.currentUser!.uid);
            BlocProvider.of<UserBloc>(context).add(LoadUserData());
            return routeName.home;
          } else {
            return routeName.login;
          }
        },
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: routeName.register,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: routeName.login,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: routeName.home,
        builder: (context, state) {
          BlocProvider.of<UserBloc>(context).add(LoadUserData());
          BlocProvider.of<ListProductsBloc>(context).add(FetchListProduct());
          BlocProvider.of<GetCartCountCubit>(context).getCartCount();
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: routeName.admin,
            builder: (context, state) {
              return const AdminScreen();
            },
          ),
          GoRoute(
              path: routeName.detail,
              builder: (context, state) {
                final String id = state.extra as String;
                BlocProvider.of<DetailProductBloc>(context)
                    .add(FetchDetailProduct(docId: id));
                return const DetailProductScreen();
              }),
          GoRoute(
              path: routeName.cart,
              builder: (context, state) {
                BlocProvider.of<CartProductBloc>(context).add(FetchListCart());
                // BlocProvider.of<GetCartCountCubit>(context).getCartCount();
                return const CartProductScreen();
              }),
        ],
      )
    ]);
