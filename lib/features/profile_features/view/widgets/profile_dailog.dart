import 'package:flutter/material.dart';
import 'package:rolesphere_messenger/features/chat_features/data/models/chat_user_model.dart';
import 'package:rolesphere_messenger/features/profile_features/view/screens/view_profile_screen.dart';
import 'package:rolesphere_messenger/features/profile_features/view/widgets/profile_image.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(.9),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      content: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height * .35,
          child: Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height * .075,
                left: MediaQuery.of(context).size.width * .1,
                child: ProfileImage(
                    size: MediaQuery.of(context).size.width * .5,
                    url: user.image),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * .04,
                top: MediaQuery.of(context).size.height * .02,
                width: MediaQuery.of(context).size.width * .55,
                child: Text(user.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Positioned(
                  right: 8,
                  top: 6,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewProfileScreen(user: user)));
                    },
                    minWidth: 0,
                    padding: const EdgeInsets.all(0),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.info_outline,
                        color: Colors.blue, size: 30),
                  ))
            ],
          )),
    );
  }
}
