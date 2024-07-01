// ignore_for_file: use_build_context_synchronously

import 'package:chat_setup/constan.dart';
import 'package:chat_setup/cubits/login_cubit/login_cubit.dart';
import 'package:chat_setup/helper/show_snack.dart';
import 'package:chat_setup/screens/chat_screen.dart';
import 'package:chat_setup/screens/signup.dart';

import 'package:chat_setup/widget/Custom_TextField.dart';
import 'package:chat_setup/widget/Custom_Container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatelessWidget {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          loading = true;
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
        } else if (state is LoginFailure){
     showSnaackBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
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
                          'LOGIN',
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
                  CustomContainer(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).loginUser(
                          email: email!,
                          password: password!,
                        );
                        // loading = true;

                        // try {
                        //   await loginUser();

                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (context) {
                        //     return ChatPage();
                        //   }));
                        // } on FirebaseAuthException catch (e) {
                        //   if (e.code == 'user-not-found') {
                        //     showSnaackBar(
                        //         context, 'No user found for that email.');
                        //   } else if (e.code == 'wrong-password') {
                        //     showSnaackBar(
                        //         context, 'Wrong password for that user.');
                        //   }
                        // } catch (e) {
                        //   return showSnaackBar(context, 'there was an error');
                        // }
                        // loading = false;
                      }
                    },
                    textButton: 'LogIn',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'dont have an account ? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUp();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
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
      ),
    );
  }

  Future<void> loginUser() async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
