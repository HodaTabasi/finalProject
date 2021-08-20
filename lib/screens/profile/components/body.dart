import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/NavigatorKey.dart';
import 'package:shop_app/screens/profile/edit_user/edit_user_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              NavigationService.navigationService.navigateTo(EditProfileScreen.routeName)
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {

            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () async {
              const uri =
                  'mailto:admin@gmail.com?subject=Help Center';
              if (await canLaunch(uri)) {
              await launch(uri);
              } else {
              throw 'Could not launch $uri';
              }
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              SPHelper.sp.clearAll();
              Navigator.of(context)
                  .pushAndRemoveUntil(
                CupertinoPageRoute(
                    builder: (context) => SignInScreen()
                ),
                    (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
