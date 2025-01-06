import 'package:flutter/material.dart';
import 'package:rolesphere_messenger/core/app_functions.dart';
import 'package:rolesphere_messenger/features/chat_features/data/models/chat_user_model.dart';
import '../widgets/profile_image.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          appBar: AppBar(title: Text(widget.user.name)),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Joined On: ',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Text(
                  AppFunctions.getLastMessageTime(
                      context: context,
                      time: widget.user.createdAt,
                      showYear: true),
                  style: const TextStyle(color: Colors.black54, fontSize: 15)),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .03),
                  ProfileImage(
                    size: MediaQuery.of(context).size.height * .2,
                    url: widget.user.image,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .03),
                  Text(widget.user.email,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16)),
                  SizedBox(height: MediaQuery.of(context).size.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'About: ',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(widget.user.about,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
