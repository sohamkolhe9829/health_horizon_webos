enum ChatMessageType { user, ai }

class ChatMessage {
  String? text;
  ChatMessageType? type;

  ChatMessage({this.text, this.type});
}
