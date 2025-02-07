import 'dart:io';

import 'package:flutter/material.dart';

import '../models/message.dart';


class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => ChatViewState();
}

class ChatViewState extends State<ChatView> {
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _sendMessage({required Message message}) {
    final text = message.text;
    final senderValue = message.isSender;
    final image = message.imagePath;
    final time = message.timestamp;

    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(
          text: text, 
          isSender: senderValue, 
          timestamp: time,
          imagePath: image,
        ));

         _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    }
  }

  void sendMessageFromParent(Message message) {
    _sendMessage(message: message);
  }

  int getMessagesCount() {
    return _messages.length;
  }

  void clearMessagesFromParent() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      // Chat messages list
      Expanded(
        child: Visibility(
          visible: true,
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          )
      );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      // Align messages to left or right based on sender
      alignment: message.isSender 
        ? Alignment.centerRight 
        : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: message.isSender 
            ? Colors.blue[100] 
            : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: message.isSender 
              ? const Radius.circular(16) 
              : const Radius.circular(0),
            bottomRight: message.isSender 
              ? const Radius.circular(0) 
              : const Radius.circular(16),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            if (!message.isSender) const Image(height: 25, image: AssetImage("assets/images/vertex_logo.png")),
            if (!message.isSender) const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
            Flexible(
               child: Column(children: [
                Text(
                message.text,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                if (message.imagePath != null) Container(
                  margin: const EdgeInsets.all(10),
                  height: 150,
                  child:  Image.file(File(message.imagePath!)),
                ),
               ],)
              ), 
        ],),
      ),
    );
  }
}