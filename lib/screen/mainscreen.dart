import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    SafeArea(child: Text("Product")),
    SafeArea(child: Text("Cart")),
    SafeArea(child: Text("Account")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 8,
          color: Colors.white,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonNav(
                  title: "Products",
                  iconActive: Icons.home_outlined,
                  isActive: _selectedIndex == 0,
                  onTap: () {
                    print(0);
                    _selectedIndex = 0;
                    setState(() {});
                  },
                ),
                ButtonNav(
                  title: "Cart",
                  iconActive: Icons.shopping_bag_outlined,
                  isActive: _selectedIndex == 1,
                  showBadge: true,
                  counter: 20,
                  onTap: () {
                    print(1);
                    _selectedIndex = 1;
                    setState(() {});
                  },
                ),
                ButtonNav(
                  title: "Account",
                  iconActive: Icons.people_outline,
                  isActive: _selectedIndex == 2,
                  onTap: () {
                    print(2);
                    _selectedIndex = 2;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
        body: _widgetOptions[_selectedIndex]);
  }
}

class ButtonNav extends StatelessWidget {
  const ButtonNav({
    this.onTap,
    this.isActive = false,
    this.iconActive,
    required this.title,
    this.showBadge = false,
    this.counter = 0,
  });

  final String title;
  final IconData? iconActive;
  final bool isActive;
  final Function()? onTap;
  final bool showBadge;
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 70,
            child: Column(
              children: [
                Icon(
                  iconActive,
                  color:
                      isActive ? Theme.of(context).primaryColor : Colors.grey,
                ),
                Spacer(),
                Text(
                  title,
                  style: TextStyle(
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                ),
              ],
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Container(
                color: Colors.red,
                child: Text(
                  counter.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
      ],
    );
  }
}
