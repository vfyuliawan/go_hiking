// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
part of 'widgets.dart';

class CustomAppbar extends StatelessWidget {
  final IconData leftIcon;
  final IconData righttIcon;
  final Function? leftCallback;

  const CustomAppbar(this.leftIcon, this.righttIcon, {this.leftCallback});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: leftCallback != null ? () => leftCallback : null,
            child: _buildIcon(leftIcon),
          ),
          _buildIcon(righttIcon)
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Icon(icon),
    );
  }
}
