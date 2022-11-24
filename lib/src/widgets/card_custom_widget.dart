// ignore_for_file: prefer_const_constructors

part of 'widgets.dart';

class CardCustomWidget extends StatelessWidget {
  final String? image, title, country;
  final double? price;
  final Function? press;

  const CardCustomWidget({
    super.key,
    this.image,
    this.title,
    this.country,
    this.price,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding,
      ),
      width: 100,
      child: Column(
        children: <Widget>[
          Image(
            image: NetworkImage(image!),
          ),
          8.heightBox,
          GestureDetector(
            onTap: null,
            child: Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "${title}".text.bold.make(),
                    8.heightBox,
                    "RP. ${price}".text.make()
                  ],
                )),
          )
        ],
      ),
    );
  }
}
