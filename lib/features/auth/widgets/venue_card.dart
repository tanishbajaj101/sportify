import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/core/utils.dart';

class VenueCard extends ConsumerWidget {
  final String venue;
  final String bio;
  const VenueCard({
    super.key,
    required this.venue,
    required this.bio,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: size.width * 1,
        height: size.height * 0.5,
        child: Card(
          elevation: 12,
          child: Center(
            child: Column(children: [
              Text(
                venue,
                style: GoogleFonts.roboto(fontSize: 30),
              ),
              Text(bio),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    // update value of a variable and use it in map_view using ref.watch() to update it to join now

                    showSnackBar(context, 'Congratulations!');
                    Navigator.pop(context);
                  },
                  child: const Text('Book Now!')),
            ]),
          ),
        ),
      ),
    );
  }
}
