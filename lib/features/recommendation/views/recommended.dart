import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/common/common.dart';
import 'package:hackathon/constants/assets_constants.dart';
import 'package:hackathon/core/utils.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/chat/controller/server_controller.dart';
import 'package:hackathon/features/chat/view/chat_view.dart';
import 'package:hackathon/features/recommendation/controller/recommendation_controller.dart';
import 'package:hackathon/models/user_model.dart';

List<UserModel> recommendedUsers = [];
late UserModel curUser;
bool check = false;

class Recommendations extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => Recommendations(),
      );
  final prov = FutureProvider((ref) async {
    final vari =
        await ref.watch(userProfileControllerProvider.notifier).getUsers();
    return vari;
  });
  Recommendations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUser = ref.watch(currentUserDetailsProvider).value!;
    return ref.watch(prov).when(
      data: (recommendedUsers) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: AppBar(
                title: const Text('Sportify'),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image(
                      image: NetworkImage('https://i.ibb.co/gjRHGP8/ss.png')),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: recommendedUsers.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                          onTap: () {
                            ref
                                .watch(serverProvider)
                                .createConversation(
                                    curUser.uid, recommendedUsers[i].uid)
                                .then((id) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    collectionId: id!,
                                    chatUser: recommendedUsers[i],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Column(children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  child: Icon(Icons.person_2_outlined),
                                ),
                                Text(
                                  recommendedUsers[i].name,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ],

                              // title: Text(recommendedUsers[i].name),
                              // subtitle: Text(recommendedUsers[i].email.toString()),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40, 5, 0, 10),
                                  child: Text(
                                    'Age : ${recommendedUsers[i].age.toString()}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      recommendedUsers[i].sports.join(', '),
                                      style: TextStyle(fontSize: 17),
                                    )),
                              ],
                            )
                          ]),
                        );
                      }),
                ),
              ],
            ));
      },
      error: (e, st) {
        return ErrorText(
          error: e.toString(),
        );
      },
      loading: () {
        return const LoadingPage();
      },
    );
  }
}
