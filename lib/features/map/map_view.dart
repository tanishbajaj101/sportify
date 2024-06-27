import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/auth/widgets/venue_card.dart';
import 'package:latlong2/latlong.dart';

var bookings = Map;

class OpenStreetMap extends ConsumerStatefulWidget {
  final String collectionID;
  OpenStreetMap({
    super.key,
    required this.collectionID,
  });
  var widgets = [];
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OpenStreetMapState();
}

class _OpenStreetMapState extends ConsumerState<OpenStreetMap> {
  @override
  Widget build(BuildContext context) {
    final curUser = ref.watch(currentUserDetailsProvider).value;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(curUser!.latitude, curUser.longitude),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.hackathon',
              ),
              MarkerLayer(markers: [
                Marker(
                  point: LatLng(curUser.latitude, curUser.longitude),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.widgets = [];

                        widget.widgets.add(const VenueCard(
                            venue: 'Your Location',
                            bio:
                                'Your current location as detected by our app'));
                      });
                    },
                    child: const Icon(
                      Icons.home,
                      size: 35,
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(28.719955711991304, 77.11424093319077),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.widgets = [];

                        widget.widgets.add(const VenueCard(
                            venue: 'Central Park', bio: 'Japanese Park'));
                      });
                    },
                    child: const Icon(
                      Icons.park,
                      size: 35,
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(28.71750563315675, 77.10927100674431),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.widgets = [];

                        widget.widgets.add(const VenueCard(
                            venue: 'DDA Park',
                            bio: 'Public Park for playing Sports'));
                      });
                    },
                    child: const Icon(
                      Icons.park,
                      size: 35,
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(28.720412566613877, 77.11126453115533),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.widgets = [];
                        widget.widgets.add(const VenueCard(
                            venue: 'Crown Plaza',
                            bio: 'Best ground in history'));
                      });
                    },
                    child: const Icon(
                      Icons.hotel,
                      size: 35,
                    ),
                  ),
                ),
                Marker(
                  point: const LatLng(28.720751686061707, 77.10718747830579),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.widgets = [];
                        widget.widgets.add(
                            const VenueCard(venue: 'Rithala', bio: 'Metro'));
                      });
                    },
                    child: const Icon(
                      Icons.railway_alert_rounded,
                      size: 35,
                    ),
                  ),
                ),
              ])
            ],
          ),
          Center(
            child: Row(
              children: [...widget.widgets],
            ),
          ),
        ],
      ),
    );
  }
}
