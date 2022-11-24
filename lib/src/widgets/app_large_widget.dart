part of 'widgets.dart';

class AppLargeText extends StatelessWidget {
  double size = 30;
  final String text;
  final Color color;
  AppLargeText(
      {this.size = 30,
      super.key,
      required this.text,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}
