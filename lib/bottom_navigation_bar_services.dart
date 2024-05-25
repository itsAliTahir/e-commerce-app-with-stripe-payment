import 'package:e_commerce/home/home_screen.dart';
import 'package:e_commerce/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'favourites/favourites_screen.dart';
import 'favourites/user_manual_screen.dart';
import 'favourites/user_profile_screen.dart';

class BottomNavigationBarServices extends StatefulWidget {
  const BottomNavigationBarServices({super.key});

  @override
  State<BottomNavigationBarServices> createState() =>
      _BottomNavigationBarServicesState();
}

class _BottomNavigationBarServicesState
    extends State<BottomNavigationBarServices>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 4, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBar(
        borderRadius: BorderRadius.circular(30),
        barColor: Colors.black,
        child: TabBar(
          isScrollable: false,
          controller: tabController,
          dividerHeight: 0,
          indicatorPadding: const EdgeInsets.all(6),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
              gradient: LinearGradient(colors: [buttonColorLight, buttonColor]),
              borderRadius: BorderRadius.circular(20)),
          tabs: [
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                currentPage == 0
                    ? FluentIcons.home_more_48_filled
                    : FluentIcons.home_more_48_regular,
                color: currentPage == 0 ? Colors.white : Colors.grey,
              )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                currentPage == 1
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: currentPage == 1 ? Colors.white : Colors.grey,
              )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                currentPage == 2
                    ? FluentIcons.form_48_filled
                    : FluentIcons.form_48_regular,
                color: currentPage == 2 ? Colors.white : Colors.grey,
              )),
            ),
            SizedBox(
              height: 55,
              width: 40,
              child: Center(
                  child: Icon(
                currentPage == 3
                    ? FluentIcons.person_48_filled
                    : FluentIcons.person_48_regular,
                color: currentPage == 3 ? Colors.white : Colors.grey,
              )),
            ),
          ],
        ),
        body: (context, controller) {
          return TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              HomeScreen(),
              const MyFavouriteScreen(),
              const MyUserManualScreen(),
              const MyUserProfileScreen(),
            ],
          );
        });
  }
}
