import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/core/utils.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/home/view/home_view.dart';
import 'package:hackathon/features/recommendation/controller/recommendation_controller.dart';
import 'package:hackathon/themes/theme.dart';

int selectedIndex = -1;

class PrefferedTime extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const PrefferedTime(),
      );
  const PrefferedTime({super.key});

  @override
  ConsumerState<PrefferedTime> createState() => _PrefferedTimeState();
}

class _PrefferedTimeState extends ConsumerState<PrefferedTime> {
  late List<Icon> icons;
  late List<String> heading;
  late List<String> subtitle;
  @override
  void initState() {
    super.initState();
    icons = [
      const Icon(Icons.sunny),
      const Icon(Icons.face),
      const Icon(Icons.nightlife),
    ];
    heading = ['Morning', 'Evening', 'Night'];
    subtitle = ['6am -- 9am', '5pm -- 8pm', '8pm -- 11pm'];
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (selectedIndex == -1) {
          showSnackBar(context, "Select some time");
        } else {
          Navigator.pop(context);
        }
        ref.watch(userProfileControllerProvider.notifier).updateUserProfile(
              userModel: user!.copyWith(prefTime: selectedIndex),
              context: context,
            );
      }),
      appBar: AppBar(
        title: const Center(child: Text('Whats your preferred time')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ListView.builder(
          itemExtent: 200.0,
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: selectedIndex == index
                  ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
                  : const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: (selectedIndex == index)
                        ? const BorderSide(color: Colors.black)
                        : const BorderSide(color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                  leading: icons[index],
                  title: Text(
                    heading[index],
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(fontSize: 27)),
                  ),
                  subtitle:
                      selectedIndex == index ? Text(subtitle[index]) : null,
                  tileColor: selectedIndex == index ? Pallete.green : null,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
