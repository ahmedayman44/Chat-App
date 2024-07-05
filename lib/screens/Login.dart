import '../constan.dart';
import '../cubits/chat_cubit/chat_cubit_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../helper/show_snack.dart';
import 'chat_screen.dart';
import 'signup.dart';

import '../widget/Custom_TextField.dart';
import '../widget/Custom_Container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatelessWidget {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool loading = false;

  LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          loading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ChatPage()),
          );
          loading = false;
        } else if (state is LoginFailure) {
          showSnaackBar(context, state.errMessage);
        }
        loading = false;
      },
      builder: (context, state) => ModalProgressHUD(
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
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
