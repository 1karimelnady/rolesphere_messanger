import 'package:lottie/lottie.dart';
import 'package:rolesphere_messenger/features/profile_features/view/widgets/profile_image.dart';

import '../../../chat_features/data/models/message_mode.dart';

import 'package:flutter/material.dart';

class AiMessageCard extends StatelessWidget {
  final AiMessage message;

  const AiMessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const r = Radius.circular(15);

    return message.msgType == MessageType.bot
        ? Row(children: [
            const SizedBox(width: 6),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Image.asset('assets/images/logo.png', width: 24),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .6),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .02,
                  left: MediaQuery.of(context).size.width * .02),
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .01,
                  horizontal: MediaQuery.of(context).size.width * .02),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: const BorderRadius.only(
                      topLeft: r, topRight: r, bottomRight: r)),
              child: message.msg.isEmpty
                  ? Lottie.asset('assets/lottie/ai.json', width: 35)
                  : Text(message.msg, textAlign: TextAlign.center),
            )
          ])
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .02,
                    right: MediaQuery.of(context).size.width * .02),
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .01,
                    horizontal: MediaQuery.of(context).size.width * .02),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: const BorderRadius.only(
                        topLeft: r, topRight: r, bottomLeft: r)),
                child: Text(
                  message.msg,
                  textAlign: TextAlign.center,
                )),
            const ProfileImage(size: 35),
            const SizedBox(width: 6),
          ]);
  }
}
