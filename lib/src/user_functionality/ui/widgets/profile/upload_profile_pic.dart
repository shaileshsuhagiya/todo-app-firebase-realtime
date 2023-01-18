import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/fonts.dart';

class UploadProfilePic {
  static final TextStyle _menuSelectionStyle = TextStyle(
    fontFamily: Fonts.NORMAL,
    fontSize: 17,
    color: Colors.blue[700],
  );

  static void onUploadTaped({
    required BuildContext context,
    Function? getImageFromCamera,
    Function? getImageFromGallary,
    VoidCallback? onDeleteImage,
    bool deleteHidden = false,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              padding: const EdgeInsets.only(left: 10),
              width: 40,
              child: const Text(
                'Choose',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: Fonts.TITLE,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextButton(
                      onPressed: getImageFromCamera as void Function()?,
                      child: Text(
                        'Camera',
                        style: _menuSelectionStyle,
                      ),
                    ),
                    TextButton(
                        onPressed: getImageFromGallary as void Function()?,
                        child: Text(
                          'Gallery',
                          style: _menuSelectionStyle,
                        )),
                  ]),
            ),
          );
        });
  }
}
