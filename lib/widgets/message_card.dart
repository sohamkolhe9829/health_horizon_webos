import 'package:flutter/material.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/presentation/chat/model/chat_model.dart';

// ignore: must_be_immutable
class MessageCard extends StatelessWidget {
  ChatMessage chatMessage;
  MessageCard({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: chatMessage.type == ChatMessageType.ai
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        chatMessage.type == ChatMessageType.ai
            ? CircleAvatar(
                backgroundColor: ConstantColor.secondaryColor,
                radius: 20,
                child: Center(
                  child: Text(
                    'AI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : SizedBox(),
        SizedBox(width: 10),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ConstantColor.secondaryColor,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(
                    chatMessage.type == ChatMessageType.ai ? 15 : 0),
                bottomLeft: Radius.circular(
                    chatMessage.type == ChatMessageType.ai ? 0 : 15),
              ),
            ),
            child: Text(chatMessage.text!),
          ),
        ),
        SizedBox(width: 10),
        chatMessage.type == ChatMessageType.user
            ? CircleAvatar(
                backgroundColor: ConstantColor.secondaryColor,
                radius: 20,
                child: Center(
                  child: Text(
                    'AI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
