import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/api/server_api.dart';
import 'package:hackathon/core/providers.dart';

/// Provider for accessing [ServerApi] functions
final serverProvider = Provider<ServerApi>((ref) {
  return ServerApi(ref.watch(dartclientProvider));
});
