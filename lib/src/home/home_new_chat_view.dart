import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';

import '../chat/chat_view.dart';
import '../handlers/camera/camera_handler.dart';

class HomeNewChatView extends StatefulWidget {
  const HomeNewChatView({super.key});

  @override
  State<HomeNewChatView> createState() => HomeNewChatViewState();
}

class HomeNewChatViewState extends State<HomeNewChatView> {
bool isAttachmentBarVisible = false;
bool isLogoVisible = true;

void _changeAttachmentBarVisibility() {
  setState(() {
    isAttachmentBarVisible = !isAttachmentBarVisible;
  });
}

void _changeLogoVisibility() {
  setState(() {
    isLogoVisible = (chatKey.currentState!.getMessagesCount() > 0 ) ? false: true;
  });
}

void _changePictureTakenVisibility() {
  setState(() {
    capturedImage = null;
    imagePath = '';
  });
}

final GlobalKey<ChatViewState> chatKey = GlobalKey();
final GlobalKey<CameraHandlerState> cameraKey = GlobalKey();

TextEditingController textController = TextEditingController();
Image? capturedImage;
String? imagePath;

Future<void> _processResponseFromServer(Message message) async {
  showDialog(
    barrierDismissible: false,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 7,
          color: Color.fromRGBO(90, 140, 255, 1),
          backgroundColor: Colors.transparent,
        ),
      );
    },
    context: context,
  );

  final model = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash');
  GenerateContentResponse? response;

  if (message.imagePath == null) {
    // Provide a prompt that contains text
    final prompt = [Content.text(message.text)];
    // To generate text output, call generateContent with the text input
    response = await model.generateContent(prompt);
  }
  else if (message.imagePath != null) {
    // Provide a text prompt to include with the image
    final prompt = TextPart(message.text);
    // Prepare images for input
    final image = await File(message.imagePath!).readAsBytes();
    final imagePart = InlineDataPart('image/jpeg', image);
    // To generate text output, call generateContent with the text and image
    response = await model.generateContent([
      Content.multi([prompt,imagePart])
    ]);
  }
  Message messageResponse = Message(text: response!.text.toString(), imagePath: null, isSender: false, timestamp: DateTime.now());
  chatKey.currentState?.sendMessageFromParent(messageResponse);
  _closeDialog();
}

void _closeDialog(){
   Navigator.of(context).pop();
}

void clearMessagesFromParent() {
  chatKey.currentState?.clearMessagesFromParent();
  _changeLogoVisibility();
  _changePictureTakenVisibility();
}

@override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isLogoVisible,
          child: Container(
          margin: const EdgeInsets.fromLTRB(20, 100, 20, 50),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/images/vertex_logo.png")),
              const Padding(padding: EdgeInsets.all(10.0)),
              Text(AppLocalizations.of(context)!.homeViewMainText, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),),
              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              Text(AppLocalizations.of(context)!.homeViewAlterText, style: const TextStyle(
                fontSize: 17.0,
                color: Color.fromARGB(158, 0, 0, 0)
              ),),
            ],
          )
        ),),
        ChatView(key: chatKey),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Column(
            children: [
              CameraHandler(key: cameraKey, onImageCaptured: (Image image, String path) {
                setState(() {
                  capturedImage = image;
                  imagePath = path;
                });
                // Do something with the captured image
                _changeAttachmentBarVisibility();
              },),
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(padding: EdgeInsets.all(10.0)),
                Expanded(                
                  child: TextFormField(
                    controller: textController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.homeViewHintText,
                      labelStyle: const TextStyle( fontSize: 2.0, color: Colors.black),
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(9)), borderSide: BorderSide(color: Colors.black)),
                    ),
                )
                ),
                Visibility(visible: (capturedImage != null), child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  child: GestureDetector(
                      onTap: () {
                        _changePictureTakenVisibility();
                      },
                      child: capturedImage,
                    )
                ),),
                Visibility(visible: !isAttachmentBarVisible, child: IconButton(onPressed: (){ _changeAttachmentBarVisibility(); }, icon: const Icon(Icons.add), iconSize: 20.0,)),
                Visibility(visible: isAttachmentBarVisible, child: IconButton(onPressed: (){ _changeAttachmentBarVisibility(); }, icon: const Icon(Icons.close), iconSize: 20.0,)),
                IconButton(onPressed: (){
                  if (textController.text.isNotEmpty) {
                    Message message = Message(
                      text: textController.text,
                      imagePath: (capturedImage != null) ? imagePath : null,
                      isSender: true,
                      timestamp: DateTime.now(),
                    );
                    chatKey.currentState?.sendMessageFromParent(message);
                    _changeLogoVisibility();
                    _processResponseFromServer(message);
                    textController.text = '';
                    capturedImage = null;
                  }
                }, icon: const Icon(Icons.send), iconSize: 20.0, color: const Color.fromRGBO(90, 140, 255, 1)),
              ],
            ),
            Visibility(
              visible: isAttachmentBarVisible,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  IconButton(onPressed: (){
                    cameraKey.currentState?.takePhoto();
                  }, icon: const Icon(Icons.camera), iconSize: 20.0,),
                  Text(AppLocalizations.of(context)!.homeViewCameraText),
                ],),
                Column(children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.image), iconSize: 20.0, color: Colors.grey,),
                  Text(AppLocalizations.of(context)!.homeViewImageText, style: const TextStyle(color: Colors.grey),),
                ],),
                Column(children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.picture_as_pdf), iconSize: 20.0, color: Colors.grey,),
                  Text(AppLocalizations.of(context)!.homeViewDocumentText, style: const TextStyle(color: Colors.grey),),
                ],),
              ],
              ),)
            ],
          )
        )
    ],);
  }
}