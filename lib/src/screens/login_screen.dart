// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoginIsFailed) {
            Commons().showSnackbar(context, state.message);
          } else if (state is LoginIsSuccess) {
            BlocProvider.of<UserBloc>(context).add(LoadUserData());
            context.go(routeName.home);
            Commons().showSnackbarInfo(context, "Welcome Back ");
          }
        },
        child: VStack([
          // TODO: Add up your widgets
          VxBox(
                  child: Column(
            children: [
              Container(
                height: 200,
                width: context.percentHeight * 30,
                child: Lottie.network(
                    'https://assets5.lottiefiles.com/packages/lf20_yw6eoerq.json',
                    fit: BoxFit.contain),
              ),
              16.heightBox,
              "Let's Hiking"
                  .text
                  .bold
                  .color(Color.fromARGB(255, 5, 35, 70))
                  .size(28)
                  .make()
            ],
          ))
              .p4
              .size(context.screenWidth, context.percentHeight * 35)
              .linearGradient([kPrimaryColor, kPrimary2Color])
              .bottomLeftRounded(value: 60)
              // .bgImage(
              //   DecorationImage(
              //       image: AssetImage("images/logo oke.png"), scale: 7),
              // )
              .make(),
          'Login'.text.headline5(context).make().p16(),
          _buildLoginForm()
        ]),
      ).scrollVertical(physics: AlwaysScrollableScrollPhysics())),
    );
  }

  Widget _buildLoginForm() {
    return VStack([
      // TODO: Add up your widgets
      TextFieldWidget(
        controller: emailController,
        title: 'Email',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: passController,
        title: 'Password',
        isPassword: true,
      ),
      16.heightBox,

      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ButtonWidget(
            color: kPrimaryColor,
            text: 'Login',
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(LoginUser(
                  email: emailController.text, password: passController.text));
            },
          );
        },
      ),
      8.heightBox,
      "Dont Have An Account"
          .richText
          .size(12)
          .withTextSpanChildren([
            " Register Here".textSpan.size(14).bold.color(kPrimaryColor).make()
          ])
          .makeCentered()
          .onTap(() {
            context.go(routeName.register);
          })
    ]).p(16);
  }
}
