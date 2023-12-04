import 'package:flutter/material.dart';
import 'package:invotask/Screen/calender_screen.dart';
import 'package:invotask/Screen/category.dart';
import 'package:invotask/Screen/chat.dart';
import 'package:invotask/Screen/homescreen.dart';
import 'package:invotask/Screen/profilescreen.dart';
import 'package:invotask/constant.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CalenderScreen(),
    const ChatScreen(),
    const ContactScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        
        color: Colors.white,
        notchMargin: 4,
        height: 60,
        elevation: 1,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),

                  onTap: () {
                    setState(() {
                      currentScreen = const HomeScreen();
                      currentTab = 0;
                    });
                  },
                  child: Icon(
                    Icons.home,
                    color: currentTab == 0
                        ? Appcolor.maincolor
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,

                child: InkWell(
                  borderRadius: BorderRadius.circular(30),

                  onTap: () {
                    setState(() {
                      currentScreen = const CategoryScreen();
                      currentTab = 1;
                    });
                  },
                  child: SizedBox(
                      child: Icon(
                    Icons.dashboard,
                    color: currentTab == 1
                        ? Appcolor.maincolor
                        : Colors.black,
                  )),
                ),
              ),
            ),
            //Right Tab Bar icon
            Expanded(
              child: SizedBox(
                height: 60,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),

                  onTap: () {
                    setState(() {
                      currentTab = 2;
                      currentScreen = const CalenderScreen();
                    });
                  },
                  child: Icon(
                   Icons.calendar_month_outlined,
                    
                    // ignore: deprecated_member_use
                    color: currentTab == 2
                        ? Appcolor.maincolor
                        : Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 60,

                child: InkWell(
                  borderRadius: BorderRadius.circular(30),

                  onTap: () {
                    setState(() {
                      currentTab = 3;
                      currentScreen = const ChatScreen();
                    });
                  },
                  child: Icon(
                   Icons.message_rounded,
                    
                    // ignore: deprecated_member_use
                    color: currentTab == 3
                        ? Appcolor.maincolor
                        : Colors.black,
                  ),
                ),
              ),
            ),
             Expanded(
              child: SizedBox(
                height: 60,

                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    setState(() {
                      currentTab = 4;
                      currentScreen = const ContactScreen();
                    });
                  },
                  child: Icon(
                   Icons.person,
                    
                    // ignore: deprecated_member_use
                    color: currentTab == 4
                        ? Appcolor.maincolor
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen {
  const ProfileScreen();
}
