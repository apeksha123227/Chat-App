import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/App_colors.dart';
import 'Call/Calls_Screen.dart';
import 'Chat/Chats_Screen.dart';
import 'DashBoard_Controller.dart';

class DashBoard_Screen extends StatelessWidget {
  DashBoard_Screen({super.key});

  final controller = Get.put(DashBoard_Controller());

  @override
  Widget build(BuildContext context) {
    final screen = [
      Chats_Screen(),
      Calls_Screen(),
      Calls_Screen(),
      Calls_Screen(),
    ];

    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (controller.selectedTabIndex.value != 0) {
            controller.selectedTabIndex.value = 0;
            return false;
          }
          return true;
        },
        child: Scaffold(
          //  body: screen[controller.selectedTabIndex.value],
          body: IndexedStack(
            index: controller.selectedTabIndex.value,
            children: screen,
          ),
          bottomNavigationBar: Material(
            elevation: 15,
            child: BottomNavigationBar(
              onTap: controller.changeTab,
              currentIndex: controller.selectedTabIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: App_colors.orange,
              unselectedItemColor: App_colors.blackLight,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,

              items: [
                BottomNavigationBarItem(
                  /*icon: SvgPicture.asset(
                    "assets/images/home.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.blackLight,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/images/home.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.orange,
                      BlendMode.srcIn,
                    ),
                  ),*/
                  icon: SizedBox.shrink(),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  /*  icon: SvgPicture.asset(
                    "assets/images/service.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.blackLight,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/images/service.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.orange,
                      BlendMode.srcIn,
                    ),
                  ),*/
                  icon: SizedBox.shrink(),
                  label: "Services",
                ),
                BottomNavigationBarItem(
                  /* icon: SvgPicture.asset(
                    "assets/images/book.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.blackLight,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/images/book.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.orange,
                      BlendMode.srcIn,
                    ),
                  ),*/
                  icon: SizedBox.shrink(),
                  label: "Bookings",
                ),
                BottomNavigationBarItem(
                  /* icon: SvgPicture.asset(
                    "assets/images/user.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.blackLight,
                      BlendMode.srcIn,
                    ),
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/images/user.svg",
                    colorFilter: ColorFilter.mode(
                      App_colors.orange,
                      BlendMode.srcIn,
                    ),
                  ),*/
                  icon: SizedBox.shrink(),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
