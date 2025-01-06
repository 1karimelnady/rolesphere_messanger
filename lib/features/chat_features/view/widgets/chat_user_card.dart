import 'package:flutter/material.dart';
import 'package:rolesphere_messenger/api/apis.dart';
import 'package:rolesphere_messenger/core/app_functions.dart';
import 'package:rolesphere_messenger/features/chat_features/data/models/chat_user_model.dart';
import 'package:rolesphere_messenger/features/chat_features/data/models/message_mode.dart';
import 'package:rolesphere_messenger/features/chat_features/view/screens/chat_screen.dart';
import 'package:rolesphere_messenger/features/profile_features/view/widgets/profile_image.dart';

import '../../../profile_features/view/widgets/profile_dailog.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04, vertical: 4),
      // color: Colors.blue.shade100,
      elevation: 0.5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user)));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) _message = list[0];

              return ListTile(
                leading: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => ProfileDialog(user: widget.user));
                  },
                  child: ProfileImage(
                      size: MediaQuery.of(context).size.height * .055,
                      url: widget.user.image),
                ),
                title: Text(widget.user.name),
                subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                            ? 'image'
                            : _message!.msg
                        : widget.user.about,
                    maxLines: 1),
                trailing: _message == null
                    ? null
                    : _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 230, 119),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          )
                        : Text(
                            AppFunctions.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: const TextStyle(color: Colors.black54),
                          ),
              );
            },
          )),
    );
  }
}
