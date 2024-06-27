import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/common/error_page.dart';
import 'package:hackathon/common/loading_page.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/chat/controller/server_controller.dart';
import 'package:hackathon/features/chat/view/chat_view.dart';
import 'package:hackathon/features/recommendation/controller/recommendation_controller.dart';
import 'package:hackathon/models/user_model.dart';

List<UserModel> recommendedUsers = [];
late UserModel curUser;

class ExistingChats extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => ExistingChats(),
      );

  const ExistingChats({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExistingChatsState();
}

class _ExistingChatsState extends ConsumerState<ExistingChats> {
  final prov = FutureProvider((ref) async {
    final vari =
        await ref.watch(userProfileControllerProvider.notifier).getUsers();
    return vari;
  });
  @override
  Widget build(BuildContext context) {
    final curUser = ref.watch(currentUserDetailsProvider).value!;
    return ref.watch(prov).when(
      data: (recommendedUsers) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('App'),
          ),
          body: ListView.builder(
              itemCount: recommendedUsers.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
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
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_2_outlined),
                    // child: SvgPicture.string(recommendedUsers[i].profilePic),
                  ),
                  title: Text(recommendedUsers[i].name),
                  subtitle: Text(recommendedUsers[i].email.toString()),
                );
              }),
        );
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
