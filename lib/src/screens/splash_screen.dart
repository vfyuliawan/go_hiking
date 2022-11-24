// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

//Velocity
//VStack = Column
//Hstack = Row
//ZStack = Stack

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _initWidget();
    // Scaffold(
    //   body: VStack(['Go Hiking'.text.bold.make()]).centered(),
    // );
  }

  Widget _initWidget() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 208, 161),
                // ignore: prefer_const_literals_to_create_immutables
                gradient: LinearGradient(colors: [
                  (Color.fromARGB(255, 36, 229, 178)),
                  (Color.fromARGB(255, 251, 198, 83))
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Center(child: Container(child: Image.asset("images/logo oke.png")))
        ],
      ),
    );
  }
}
