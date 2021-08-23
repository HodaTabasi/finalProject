import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/helper/LocalStorage/sp_helper.dart';
import 'package:shop_app/helper/backendHelper/firebase_helper.dart';
import 'package:shop_app/helper/backendHelper/firestore_helper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage:
                (SPHelper.sp.sharedPreferences.getString("imageUrl") == null)
                    ? AssetImage("assets/images/Profile Image.png")
                    : NetworkImage(
                        SPHelper.sp.sharedPreferences.getString("imageUrl")),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () async {
                  PickedFile pickedFile = await ImagePicker()
                      // ignore: deprecated_member_use
                      .getImage(source: ImageSource.gallery);
                  String imageUrl = await FirebaseHelper.firebaseHelper
                      .uploadImage(File(pickedFile.path));

                  if (!imageUrl.isEmpty) {
                    bool b = await FireStoreHelper.fireStoreHelper
                        .setUserImage(imageUrl);
                    if (b) {
                      SPHelper.sp.sharedPreferences
                          .setString("imageUrl", imageUrl);
                      setState(() {});
                    } else {
                      Fluttertoast.showToast(
                          msg: "Error",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
