import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/features/home/view/pageone.dart';
import 'package:hackathon/features/home/view/pagethree.dart';
import 'package:hackathon/features/home/view/pagetwo.dart';
import 'package:hackathon/features/recommendation/views/existing_chats.dart';
import 'package:hackathon/features/recommendation/views/recommended.dart';
import 'package:hackathon/themes/theme.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.basketball,
        // here we define color of a svg picture
        colorFilter: const ColorFilter.mode(Pallete.green, BlendMode.color),
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    Recommendations(),
    ExistingChats(),
    PageThreeClass(),
  ];
}
