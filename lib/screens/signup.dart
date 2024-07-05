// ignore_for_file: use_build_context_synchronously

import 'package:chat_setup/constan.dart';
import 'package:chat_setup/cubits/auth_cubit/auth_cubit.dart';

import 'package:chat_setup/helper/show_snack.dart';
import 'package:chat_setup/screens/chat_screen.dart';
import 'package:chat_setup/widget/Custom_Container.dart';
import 'package:chat_setup/widget/Custom_TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatelessWidget {
  String? email;

  String? password;

  bool loading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SinupLoading) {
          loading = true;
        } else if (state is SinupSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChatPage()));
          loading = false;
        } else if (state is SinupFailure) {
          showSnaackBar(context, state.errMessage);
          loading = false;
        }
      },
      builder: (context, state) {
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
                          BlocProvider.of<AuthCubit>(context)
                              .registerUser(email: email!, password: password!);
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
      },
    );
  }

  Future<void> registerUser() async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
