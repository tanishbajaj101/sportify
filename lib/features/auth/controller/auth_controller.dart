import 'dart:math';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/api/auth_api.dart';
import 'package:hackathon/api/location_api.dart';
import 'package:hackathon/api/user_api.dart';
import 'package:hackathon/constants/assets_constants.dart';
import 'package:hackathon/core/utils.dart';
import 'package:hackathon/features/auth/view/login_view.dart';
import 'package:hackathon/features/auth/view/signup_view.dart';
import 'package:hackathon/features/home/view/home_view.dart';
import 'package:hackathon/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  // value is the ref.read outside of the callback of a riverpod provider
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);
  // state = isLoading

  Future<User?> currentUser() => _authAPI.currentUserAccount();

  void signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    final loc = await determinePosition();
    final defaultpic = SvgPicture.asset(
      AssetsConstants.profilePic,
      colorFilter: ColorFilter.mode(
          Colors.primaries[Random().nextInt(Colors.primaries.length)],
          BlendMode.dstATop),
    ).toString();

    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: name,
          age: 18,
          sports: const [],
          prefTime: -1,
          longitude: loc.longitude,
          latitude: loc.latitude,
          profilePic: defaultpic,
          gender: 0,
          uid: r.$id,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold((l) => showSnackBar(context, l.message), (r) {
          showSnackBar(context, 'Accounted created! Please login.');
          Navigator.push(context, LoginView.route());
        });
      },
    );
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.push(context, HomeView.route());
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    // we were accessing data from providers which gave us continuous listening to a user and its respective data

    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }

  void logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => null, (r) {
      Navigator.pushAndRemoveUntil(
        context,
        SignUpView.route(),
        (route) => false,
      );
    });
  }
}
