part of 'widgets.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Color bgcolor;
  double size;
  String? text = "Hi";
  IconData? icon;
  final Color borderColor;
  bool? isIcon;

  AppButton(
      {super.key,
      this.isIcon = false,
      this.text,
      this.icon,
      required this.color,
      required this.bgcolor,
      required this.borderColor,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          color: bgcolor,
          borderRadius: BorderRadius.circular(10)),
      child: isIcon == false
          ? Center(
              child: AppText(
                text: text!,
                color: color,
              ),
            )
          : Center(
              child: Icon(
                icon,
                color: color,
              ),
            ),
    );
    ;
  }
}
