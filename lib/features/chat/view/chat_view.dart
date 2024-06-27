import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon/features/auth/controller/auth_controller.dart';
import 'package:hackathon/features/chat/controller/chat_controller.dart';
import 'package:hackathon/features/map/map_view.dart';
import 'package:hackathon/models/chat_model.dart';
import 'package:hackathon/models/user_model.dart';
import 'package:hackathon/widgets/send_message.dart';

/// [ChatPage]
///
/// This is the chat page.
class ChatPage extends ConsumerWidget {
  /// CollectionId for the current convo
  final String collectionId;

  /// Data of the user whom the current user is chatting with
  /// The data is required to display the name and photo of the user
  /// ChatPage will be called from ListView.builder after everything has been created
  /// so it already has the collection ID, and chatUser passed to it from behind --> chatUser is probably ourselves
  final UserModel chatUser;
  ChatPage({required this.collectionId, required this.chatUser, Key? key})
      : super(key: key);

  /// TextFieldController for the message input
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Get Data for the currentLoggedInUser
    UserModel? user = ref.watch(currentUserDetailsProvider).value!;

    /// Get the list of ChatData
    final chatList = ref.watch(chatProvider(collectionId));

    Future<void> sendMessage(String message) async {
      if (message.isEmpty) return;

      /// Parse the data into a proper model
      Chat data = Chat(
        senderName: user.name,
        senderid: user.uid,
        message: message,
        time: DateTime.now().toIso8601String(),
      );

      try {
        /// Send the message
        /// this has the problem
        await ref.watch(chatProvider(collectionId).notifier).sendMessage(data);

        /// Clear the text field after sending
        _textController.clear();
      } catch (e) {
        rethrow;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.blueGrey,
        leadingWidth: 20,
        elevation: 0,
        title: ListTile(
          leading: const Icon(Icons.person),
          title: Text(chatUser.name),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return OpenStreetMap(collectionID: collectionId);
                }));
              },
              // ref.watch(Map<String collectionID, bool booked>)
              // return stateprovider with type of bool
              child: const Text('Book Now')),
        ],
      ),
      body: Scaffold(
        body: ListView(
          children: [
            ...chatList,
          ],
        ),
        bottomNavigationBar: SendMessageWidget(
            textController: _textController,
            onSend: () async => await sendMessage(_textController.text)),
      ),
    );
  }
}
