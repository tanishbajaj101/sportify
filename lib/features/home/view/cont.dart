import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/themes/theme.dart';

List<String> sports = [];
final sportsProvider = Provider<List<String>>((ref) => sports);

class SportCont extends StatefulWidget {
  final String sport;
  final String url;
  const SportCont({
    super.key,
    required this.sport,
    required this.url,
  });

  @override
  State<SportCont> createState() => _SportContState();
}

class _SportContState extends State<SportCont> {
  late bool isSelected;
  @override
  void initState() {
    isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
                if (isSelected) {
                  sports.add(widget.sport);
                } else {
                  sports.remove(widget.sport);
                }
              });
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: Pallete.green, width: 10)
                    : null,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(widget.url),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 5,
            ),
            child: Text(
              widget.sport,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
