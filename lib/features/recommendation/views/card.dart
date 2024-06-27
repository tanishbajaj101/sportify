import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/features/home/view/home_view.dart';
import 'package:hackathon/models/user_model.dart';
import 'package:hackathon/themes/theme.dart';

class RecommendedUserCard extends ConsumerWidget {
  final UserModel user;
  const RecommendedUserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          // confirm the selected user, or chat with them
          //
          // or display more details about that user
          HomeView.route(),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic),
                  radius: 35,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: GoogleFonts.sacramento(
                              textStyle: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    // row for displaying icons
                    Row(
                      children: [
                        ListView.builder(
                          itemCount: user.sports.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SvgPicture.string(
                              'AssetsConstants.${user.sports[index]}',
                              height: 10,
                              width: 10,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        )
                      ],
                    ),
                    // row for displaying age and M/F which will give 0,1,2 right now
                    Row(
                      children: [
                        Text(
                          user.age.toString() + user.gender.toString(),
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(fontSize: 10)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Pallete.greyColor),
        ],
      ),
    );
  }
}
