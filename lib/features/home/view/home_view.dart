import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/constants/constants.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/home/view/homepage.dart';
import 'package:hackathon/features/home/view/timings.dart';
import 'package:hackathon/themes/theme.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _page == 0 ? appBar : null,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currUserDetails = ref.watch(currentUserDetailsProvider).value;
          if (currUserDetails != null) {
            if (currUserDetails.sports.isEmpty) {
              Navigator.push(context, HomePage.route());
            } else if (ref.watch(currentUserDetailsProvider).value!.prefTime ==
                -1) {
              Navigator.push(context, PrefferedTime.route());
            } else {
              Navigator.push(context, HomeView.route());
            }
          }
        },
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat)),
          BottomNavigationBarItem(icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
