import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vallassignment/auth/screens/signup_screen.dart';
import 'package:vallassignment/events/bloc/event_bloc.dart';
import 'package:vallassignment/events/repository/event_repository.dart';

import 'auth/bloc/auth_bloc.dart';
import 'auth/repository/auth_repository.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final authRepo = AuthRepository();
  final eventRepo = EventsRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc(authRepo)),
        BlocProvider<EventsBloc>(create: (_) => EventsBloc(eventRepo)),
      ],
      child: VallAssignment(),
    ),
  );
}


class VallAssignment extends StatelessWidget {
  const VallAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}
