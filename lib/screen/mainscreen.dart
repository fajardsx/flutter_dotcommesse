import 'package:dotcom_mart/controller/cart_controller.dart';
import 'package:dotcom_mart/screen/cartlistscreen.dart';
import 'package:dotcom_mart/screen/productslist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late FirebaseMessaging _messaging;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    SafeArea(child: ProductListScreen()),
    SafeArea(child: CartListScreen()),
    SafeArea(child: Text("Account")),
  ];
  @override
  void initState() {
    super.initState();
    registerNotification();
    checkForInitialMessage(); // handle notif went apps full close
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("Message diterima di background");
      print(event.notification!.title);
      print(event.notification!.body);
      Get.snackbar("Notification",
          "${event.notification!.title}\n${event.notification!.body}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Theme.of(context).accentColor);
    });
  }

  registerNotification() {
    _messaging = FirebaseMessaging.instance;
    _messaging.getToken().then((value) => print("Token FCM : ${value}"));
    //Open app notif
    FirebaseMessaging.onMessage.listen((event) {
      print("Message Diterima");
      print(event.notification!.title);
      print(event.notification!.body);
      Get.snackbar("Notification",
          "${event.notification!.title}\n${event.notification!.body}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Theme.of(context).accentColor);
    });
    //background app notif listener
    FirebaseMessaging.onBackgroundMessage(_firebasemessagingBackgroundHandler);
  }

  Future _firebasemessagingBackgroundHandler(RemoteMessage message) async {
    print(message.messageId);
  }

  //NOTE OPTOPNAL , handle terima notif ketika apps full close
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print(initialMessage.notification!.body);
      print(initialMessage.data.toString());
      Get.snackbar("Notification",
          "${initialMessage.notification!.title}\n${initialMessage.notification!.body}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Theme.of(context).accentColor);
    }
  }

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
                GetBuilder<CartController>(
                  init: CartController(),
                  builder: (controller) {
                    return ButtonNav(
                      title: "Cart",
                      iconActive: Icons.shopping_bag_outlined,
                      isActive: _selectedIndex == 1,
                      showBadge: controller.itemCount > 0,
                      counter: controller.itemQtyCount,
                      onTap: () {
                        print(1);
                        _selectedIndex = 1;
                        setState(() {});
                      },
                    );
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
            padding: EdgeInsets.all(10),
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
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
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
