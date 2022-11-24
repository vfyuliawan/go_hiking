// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  Function? onTap;
  ResponsiveButton({
    Key? key,
    this.isResponsive,
    this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
        child: Row(
          mainAxisAlignment: isResponsive == true
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            isResponsive == true
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    child: AppText(
                      text: "Buy",
                      color: Colors.white,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(left: 20),
                    child: AppText(
                      text: "Buy",
                      color: Colors.white,
                    ),
                  ),
            // Image.asset("img/button-one.png")
          ],
        ),
      ),
    );
  }
}
