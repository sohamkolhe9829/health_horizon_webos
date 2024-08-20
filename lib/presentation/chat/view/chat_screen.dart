import 'package:flutter/material.dart';
import 'package:health_horizon_webos/presentation/chat/view/chat_widget.dart';
import 'package:health_horizon_webos/presentation/side_panel.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidePanel(selectedIndex: 1),
          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(5)),
            height: MediaQuery.of(context).size.height,
          ),
          const Flexible(
            flex: 4,
            child: ChatWidget(),
          ),
        ],
      ),
    );
  }
}
