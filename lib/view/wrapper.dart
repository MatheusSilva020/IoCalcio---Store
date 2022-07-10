import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_screen.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

import 'main_app.dart';
import 'register_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WrapperState();
  }
}

class WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Erro do Firebase"),
                  content: Text(state.message),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return const MainApp();
        } else {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                body: const TabBarView(
                  children: [
                    MyFirstScreen(),
                    MyFifthScreen()
                  ],
                ),
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: const Text("Página inicial"),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: "Login"),
                      Tab(text: "Novo cadastro")
                    ],
                  ),
                ),
              ));
        }
      },
    );
  }
}
