import 'package:flutter/material.dart';

/// [SendMessageWidget]
///
/// A Custom widget with TextField and Send Button
class SendMessageWidget extends StatelessWidget {
  final VoidCallback? onSend;
  const SendMessageWidget({
    Key? key,
    this.onSend,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: TextFormField(
                controller: _textController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableIMEPersonalizedLearning: true,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusColor: Colors.white24,
                  fillColor: Colors.white24,
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.insert_emoticon),
                    splashRadius: 10,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onSend,
            child: const CircleAvatar(
                backgroundColor: Colors.lightBlue,
                radius: 22.0,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
