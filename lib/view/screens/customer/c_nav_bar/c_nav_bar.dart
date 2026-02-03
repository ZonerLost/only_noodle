import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_explore/c_explore.dart';
import 'package:only_noodle/view/screens/customer/c_home/c_home.dart';
import 'package:only_noodle/view/screens/customer/c_order_history/c_order_history.dart';
import 'package:only_noodle/view/screens/customer/c_profile/c_profile.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/controllers/profile_controller.dart';

// ignore: must_be_immutable
class CBottomNavBar extends StatefulWidget {
  @override
  _CBottomNavBarState createState() => _CBottomNavBarState();
}

class _CBottomNavBarState extends State<CBottomNavBar> {
  int _currentIndex = 0;
  late final ProfileController _profileController;
  void _getCurrentIndex(int index) => setState(() {
    _currentIndex = index;
  });

  @override
  void initState() {
    super.initState();
    _profileController = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _items = [
      {'icon': Assets.imagesHome, 'iconA': Assets.imagesHomeA, 'label': 'Home'},
      {
        'icon': Assets.imagesExplore,
        'iconA': Assets.imagesExploreA,
        'label': 'Explore',
      },
      {
        'icon': Assets.imagesHistory,
        'iconA': Assets.imagesHistoryA,
        'label': 'History',
      },
      {'icon': '', 'iconA': '', 'label': 'Profile'},
    ];

    final List<Widget> _screens = [
      CHome(),
      CExplore(),
      COrderHistory(),
      CProfile(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildNavBar(_items),
    );
  }

  Container _buildNavBar(List<Map<String, dynamic>> _items) {
    return Container(
      height: Platform.isIOS ? null : 80,
      decoration: BoxDecoration(
        color: kFillColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),

        boxShadow: [
          BoxShadow(
            offset: Offset(0, -4),
            blurRadius: 30,
            spreadRadius: -2,
            color: kTertiaryColor.withValues(alpha: 0.10),
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
        ),
        selectedFontSize: 9,
        unselectedFontSize: 9,
        iconSize: 18,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Colors.transparent,
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: kQuaternaryColor,
        currentIndex: _currentIndex,
        onTap: (index) => _getCurrentIndex(index),
        items: List.generate(_items.length, (index) {
          var data = _items[index];
          return BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: index == 3
                  ? Obx(
                      () => CommonImageView(
                        height: 24,
                        width: 24,
                        radius: 100,
                        url: _profileController
                                    .profile
                                    .value
                                    ?.profilePicture
                                    .isNotEmpty ==
                                true
                            ? _profileController.profile.value!.profilePicture
                            : dummyImg,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ImageIcon(
                      AssetImage(
                        _currentIndex == index ? data['iconA'] : data['icon'],
                      ),
                      size: 20,
                    ),
            ),
            label: data['label'].toString().tr,
          );
        }),
      ),
    );
  }
}
