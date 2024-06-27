import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/api/user_api.dart';
import 'package:hackathon/core/utils.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/models/user_model.dart';
import 'package:latlong2/latlong.dart';

double lat = 0.00;
double long = 0.00;
LatLngBounds bounds = LatLngBounds.fromPoints([LatLng(lat, long)]);
String controllerID = '';
int controllerAge = 18;
int controllerGender = 0;

// so when we use controllers + statenotifier it gets slightly more complex so we have to mention <UserProfileController, bool>
// which is basically the controller on whichn the provider is working and the return datatype that we are expecting

final getUserProvider = FutureProvider((ref) async {
  final userProfile =
      await ref.watch(userProfileControllerProvider.notifier).getUsers();
  return userProfile;
});
final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  return UserProfileController(
    userAPI: ref.watch(userAPIProvider),
  );
});

final getLatestUserProfileDataProvider = StreamProvider((ref) {
  final userAPI = ref.watch(userAPIProvider);
  return userAPI.getLatestUserProfileData();
});

class UserProfileController extends StateNotifier<bool> {
  final UserAPI _userAPI;

  UserProfileController({
    required UserAPI userAPI,
  })  : _userAPI = userAPI,
        super(false);

  // so in recommendationcontroller we make functions for sports and prefferedtime to update those into the userModel
  void updateUserProfile({
    required UserModel userModel,
    required BuildContext context,
  }) async {
    state = true;
    // after we locally update the value of userModel we access the userAPI to push it in
    final res = await _userAPI.updateUserData(userModel);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => Navigator.pop(context),
    );
  }

  void assignValues(WidgetRef ref) {
    lat = ref.watch(currentUserDetailsProvider).value!.latitude;
    long = ref.watch(currentUserDetailsProvider).value!.longitude;
    bounds = LatLngBounds.fromPoints([LatLng(lat, long)]);
    controllerID = ref.watch(currentUserDetailsProvider).value!.uid;
    controllerAge = ref.watch(currentUserDetailsProvider).value!.age;
    controllerGender = ref.watch(currentUserDetailsProvider).value!.gender;
  }

  Future<List<UserModel>> getUsers() async {
    // get map bounds of the user's location

    try {
      final userList = await _userAPI.getUsers(
          controllerID, controllerAge, controllerGender, bounds);
      return userList.map((tweet) => UserModel.fromMap(tweet.data)).toList();
    } catch (e) {
      rethrow;
    }
  }
  Future<List<UserModel>> getExistingChats() async {

    try {
      final userList = await _userAPI.getUsers(
          controllerID, controllerAge, controllerGender, bounds);
      return userList.map((tweet) => UserModel.fromMap(tweet.data)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
