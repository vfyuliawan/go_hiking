part of 'widgets.dart';

class SelectBarWidget extends StatefulWidget {
  const SelectBarWidget({super.key});

  @override
  State<SelectBarWidget> createState() => _SelectBarWidgetState();
}

class _SelectBarWidgetState extends State<SelectBarWidget> {
  int selectedIndex = 0;
  List<IconData> icon = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.mountain,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: icon
          .asMap()
          .entries
          .map((MapEntry map) => _buildIcon(map.key))
          .toList(),
    );
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        print(selectedIndex);
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? kPrimaryColor.withOpacity(0.15)
              : Color(0xFEE7EBEE),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon[index],
          size: 25,
          color: selectedIndex == index ? kPrimaryColor : Color(0xFFB4C1C4),
        ),
      ),
    );
  }
}
