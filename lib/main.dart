import 'package:chat_setup/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_setup/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_setup/simple_bloc_observer.dart';

import 'cubits/chat_cubit/chat_cubit_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// to call the observer
  Bloc.observer = SimpleBlocObserver();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => LoginCubit(),
        // ),
        // BlocProvider(
        //   create: (context) => SinupCubitCubit(),
        // ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogIn(),
      ),
    );
  }
}
