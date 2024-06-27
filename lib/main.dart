import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/common/error_page.dart';
import 'package:hackathon/common/loading_page.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/auth/view/login_view.dart';
import 'package:hackathon/features/auth/view/signup_view.dart';
import 'package:hackathon/features/home/view/home_view.dart';
import 'package:hackathon/features/home/view/homepage.dart';
import 'package:hackathon/features/recommendation/views/recommended.dart';
import 'package:hackathon/themes/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Twitter Clone',
      theme: AppTheme.theme,
      // give provider here
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                // it doesnt use [] but instead . to access it's values
                return HomeView();
                // not made yet
                // we can ask to start personalisation here
              }
              return const SignUpView();
            },
            error: (error, st) => ErrorPage(
              error: error.toString(),
            ),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
