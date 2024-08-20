import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/presentation/chat/controller/chat_provider.dart';
import 'package:health_horizon_webos/presentation/chat/model/chat_model.dart';
import 'package:health_horizon_webos/widgets/custom_loading.dart';
import 'package:health_horizon_webos/widgets/message_card.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  var scrollController = ScrollController();
  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ConstantColor.secondaryColor,
                      child: Center(
                        child: Text(
                          "AI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "AI Assistance",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                SizedBox(
                  height: chatProvider.index == 0
                      ? MediaQuery.of(context).size.height - 250
                      : MediaQuery.of(context).size.height - 270,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: chatProvider.isGenerating
                        ? chatProvider.chatMessages.length + 1
                        : chatProvider.chatMessages.length,
                    itemBuilder: (context, index) {
                      if (chatProvider.isGenerating) {
                        if (chatProvider.chatMessages.length == index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCircularLoading(),
                            ],
                          );
                        }
                      }
                      return MessageCard(
                        chatMessage: ChatMessage(
                          text: chatProvider.chatMessages[index].text,
                          type: chatProvider.chatMessages[index].type,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(),
            Column(
              children: [
                Container(
                  width: 162,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Row(
                    children: [
                      Bounceable(
                        onTap: () {
                          chatProvider.changeIndex(0);
                        },
                        child: Container(
                          width: 80,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: chatProvider.index == 0
                                ? ConstantColor.blueColor
                                : ConstantColor.backgroundColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Chat",
                              style: TextStyle(
                                color: chatProvider.index == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Bounceable(
                        onTap: () {
                          chatProvider.changeIndex(1);
                        },
                        child: Container(
                          width: 80,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: chatProvider.index == 1
                                ? ConstantColor.blueColor
                                : ConstantColor.backgroundColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Voice",
                              style: TextStyle(
                                fontSize: 22,
                                color: chatProvider.index == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                chatProvider.index == 0
                    ? Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ConstantColor.secondaryColor,
                                  border: Border.all()),
                              child: TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: "Enter here something.....",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Bounceable(
                            onTap: () {
                              chatProvider.sendMessage(textController.text);
                              textController.clear();
                            },
                            child: Container(
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ConstantColor.secondaryColor,
                                    border: Border.all()),
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Image.asset(
                                            'assets/icon/send_icon.png'),
                                      ),
                                      Text(
                                        " Send",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Bounceable(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: ConstantColor.secondaryColor,
                              child: Center(
                                child: SizedBox(
                                  height: 30,
                                  child:
                                      Image.asset('assets/icon/mic_icon.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Tap on mic to start talking........",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
