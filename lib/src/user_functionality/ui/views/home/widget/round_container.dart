import 'package:flutter/material.dart';

import '../../../../../configs/app_colors.dart';

class RoundContainer extends StatelessWidget {
  final String text;
  const RoundContainer({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.grey[400]!,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(text,
          style: const TextStyle(
            color: AppColor.tileColor,
            fontSize: 11,
          )),
    );
  }
}
