import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rolesphere_messenger/api/apis.dart';
import 'package:rolesphere_messenger/component/dailogs.dart';
import 'package:rolesphere_messenger/features/auth_features/view/screens/login_screen.dart';
import 'package:rolesphere_messenger/features/chat_features/data/models/chat_user_model.dart';
import 'package:rolesphere_messenger/features/profile_features/view/widgets/profile_image.dart';

//profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          //app bar
          appBar: AppBar(title: const Text('Profile Screen')),

          //floating button to log out
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
                backgroundColor: Colors.redAccent,
                onPressed: () async {
                  Dialogs.showLoading(context);

                  await APIs.updateActiveStatus(false);

                  await APIs.auth.signOut().then((value) async {
                    await GoogleSignIn().signOut().then((value) {
                      Navigator.pop(context);

                      Navigator.pop(context);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    });
                  });
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout')),
          ),

          //body
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .03),
                    Stack(
                      children: [
                        _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.height * .1)),
                                child: Image.file(File(_image!),
                                    width:
                                        MediaQuery.of(context).size.height * .2,
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    fit: BoxFit.cover))
                            : ProfileImage(
                                size: MediaQuery.of(context).size.height * .2,
                                url: widget.user.image,
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              _showBottomSheet();
                            },
                            shape: const CircleBorder(),
                            color: Colors.white,
                            child: const Icon(Icons.edit, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    Text(widget.user.email,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16)),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    TextFormField(
                      initialValue: widget.user.name,
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: 'eg. Happy Singh',
                          label: Text('Name')),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    TextFormField(
                      initialValue: widget.user.about,
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: const InputDecoration(
                          prefixIcon:
                              Icon(Icons.info_outline, color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: 'eg. Feeling Happy',
                          label: Text('About')),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * .5,
                              MediaQuery.of(context).size.height * .06)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                                context, 'Profile Updated Successfully!');
                          });
                        }
                      },
                      icon: const Icon(Icons.edit, size: 28),
                      label:
                          const Text('UPDATE', style: TextStyle(fontSize: 16)),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .03,
                bottom: MediaQuery.of(context).size.height * .05),
            children: [
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * .3,
                              MediaQuery.of(context).size.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));

                          if (mounted) Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/add_image.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * .3,
                              MediaQuery.of(context).size.height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));

                          if (mounted) Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
