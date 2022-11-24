part of 'widgets.dart';

class AppText extends StatelessWidget {
  double size = 30;
  final String text;
  final Color color;
  AppText(
      {this.size = 16,
      super.key,
      required this.text,
      this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
