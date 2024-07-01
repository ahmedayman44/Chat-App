// ignore_for_file: use_build_context_synchronously

import 'package:chat_setup/constan.dart';
import 'package:chat_setup/helper/show_snack.dart';
import 'package:chat_setup/screens/chat_screen.dart';
import 'package:chat_setup/widget/Custom_Container.dart';
import 'package:chat_setup/widget/Custom_TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;

  String? password;

  bool loading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 77,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'Pacifico-Regular.ttf'),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Text(
                        'REGESTRATION',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                CustomTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  keyBoard: TextInputType.emailAddress,
                  hinText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  keyBoard: TextInputType.visiblePassword,
                  obscureTextMode: true,
                  hinText: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomContainer(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      loading = true;
                      setState(() {});

                      try {
                        await registerUser();

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ChatPage();
                        }));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnaackBar(
                              context, 'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnaackBar(context,
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        return showSnaackBar(context, 'there was an error');
                      }
                      loading = false;
                      setState(() {});
                    }
                  },
                  textButton: 'REGESTRATION',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '..Login',
                        style: TextStyle(
                          color: Color(0XFFC2B9DB),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
