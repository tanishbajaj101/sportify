// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/home/view/cont.dart';
import 'package:hackathon/features/home/view/timings.dart';
import 'package:hackathon/features/recommendation/controller/recommendation_controller.dart';

class HomePage extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.next_plan),
          onPressed: () {
            // save the data here
            if (sports.isNotEmpty) {
              ref
                  .read(userProfileControllerProvider.notifier)
                  .updateUserProfile(
                      userModel: user!.copyWith(
                        sports: sports,
                      ),
                      context: context);
              Navigator.push(context, PrefferedTime.route());
            }
          }),
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        slivers: [
          // sliver app bar
          SliverAppBar(
            expandedHeight: 170,
            backgroundColor: Colors.black,
            leading: Icon(Icons.menu),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Choose your sports",
                style: GoogleFonts.oswald(),
              ),
              background: Container(color: Colors.blueGrey),
            ),
          ),

          // sliver items 1
          SliverToBoxAdapter(
            child: SportCont(
              sport: "Badminton",
              url: "https://i.postimg.cc/PxQHjkHg/badminton.png",
            ),
          ),
          SliverToBoxAdapter(
            child: SportCont(
              sport: "Football",
              url:
                  "https://cdn.britannica.com/51/190751-050-147B93F7/soccer-ball-goal.jpg",
            ),
          ),
          SliverToBoxAdapter(
            child: SportCont(
              sport: "Cricket",
              url:
                  "https://cdn.britannica.com/47/148847-050-C4FB5341/Cricket-bat-ball.jpg",
            ),
          ),
          SliverToBoxAdapter(
            child: SportCont(
              sport: "Gym",
              url:
                  "https://www.hussle.com/blog/wp-content/uploads/2020/12/Gym-structure-1080x675.png",
            ),
          ),

          SliverToBoxAdapter(
            child: SportCont(
              sport: "Palworld",
              url:
                  "https://cdn.cloudflare.steamstatic.com/steam/apps/1623730/header.jpg",
            ),
          ),
          SliverToBoxAdapter(
            child: SportCont(
              sport: "FIFA",
              url:
                  "https://media.contentapi.ea.com/content/dam/ea/fifa/images/fifa-generic-featured-tile-16x9.png.adapt.crop16x9.1023w.png",
            ),
          ),
        ],
      ),
    );
  }
}
