import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../model/chat_model.dart';

class ChatProvider with ChangeNotifier {
  int index = 0;

  changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  bool isGenerating = false;

  List<ChatMessage> chatMessages = [];

  sendMessage(String? text) async {
    final gemini = Gemini.instance;

    chatMessages.add(ChatMessage(text: text, type: ChatMessageType.user));
    isGenerating = true;
    notifyListeners();
    await gemini.text(text!).then((value) {
      chatMessages.add(
        ChatMessage(text: value!.output, type: ChatMessageType.ai),
      );
      isGenerating = false;
      notifyListeners();
      // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => print(e));

    notifyListeners();
  }
}
