import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../configs/app_text_style.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String? text;
  final Function()? onTap;
  final bool hasNavigation;

   const ProfileListItem({Key? key,
    required this.icon,
    this.text,
     this.onTap,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ).copyWith(
          bottom: 5,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 20,
            ),
            const SizedBox(width:10),
            Text(
              text ?? '',
              style: AppTextStyle().kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 17
              ),
            ),
            const Spacer(),
            if (hasNavigation)
              const Icon(
                LineAwesomeIcons.angle_right,
                size:40,
              ),
          ],
        ),
      ),
    );
  }
}