// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return _initWidget();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is RegisterIsFailde) {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: state.message.text.make()));
              showTopSnackBar(
                  context, CustomSnackBar.error(message: "${state.message}"));
            } else if (state is RegisterIsSuccsess) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: "Welcome ${state.data.usernama}".text.make()));
              context.go(routeName.home);
              // showTopSnackBar(
              //     context,
              //     CustomSnackBar.success(
              //         message:
              //             "Hallo, Welcome ${state.data.usernama}, Enjoy Your Life"));
            }
          },
          child: VStack([
            VxBox()
                .size(context.screenWidth, context.percentHeight * 30)
                .linearGradient(
                    [Colors.greenAccent.shade200, Colors.greenAccent.shade700])
                .bottomLeftRounded(value: 60)
                .bgImage(DecorationImage(
                    image: AssetImage("images/logo oke.png"), scale: 7))
                .make(),
            'Register'.text.headline5(context).make().p16(),
            _buildRegistrationForm()
          ]),
        ).scrollVertical(
          physics: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return VStack([
      //Text Field
      TextFieldWidget(
        controller: emailController,
        title: 'Email',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: userNameController,
        title: 'User Name',
      ),
      8.heightBox,
      TextFieldWidget(
        controller: passController,
        title: 'Password',
        isPassword: true,
      ),
      16.heightBox,
      BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return ButtonWidget(
            onPressed: () {
              BlocProvider.of<RegisterBloc>(context).add(RegisterUser(
                  username: userNameController.text,
                  email: emailController.text,
                  password: passController.text));
            },
            isLoading: (state is RegisterIsLoading) ? true : false,
            text: 'Register',
          );
        },
      ).p16(),
      8.heightBox,
      "Already Have Account"
          .richText
          .size(12)
          .withTextSpanChildren(
              [" Login Here".textSpan.size(14).bold.green500.make()])
          .makeCentered()
          .onTap(() {
            context.go(routeName.login);
          })
    ]);
  }

  Widget _initWidget() {
    return Scaffold(
        body: VStack([
      Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Color.fromARGB(255, 30, 213, 137),
                gradient: LinearGradient(colors: [
                  (Colors.greenAccent),
                  (Colors.greenAccent.shade400)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset("images/logo oke.png"),
                  ),
                  Container(
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  )
                ],
              ),
            ),
          ),
          8.heightBox,
          _buildRegistrationForm()
        ],
      ).scrollVertical(physics: AlwaysScrollableScrollPhysics()),
    ]));
  }
}
