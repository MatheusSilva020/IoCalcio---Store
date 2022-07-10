import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_bloc.dart';
import 'shoes_screen.dart';
import 'accessories_screen.dart';
import 'cart_screen.dart';
import '../bloc/monitor_bloc.dart';
import '../bloc/monitor_shoes_bloc.dart';
import '../bloc/monitor_clocks_bloc.dart';
import '../bloc/manage_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoCalcio',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const MyHomePage(title: 'IoCalcio Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(Logout());
          },
          child: const Icon(Icons.logout)),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ManageBloc()),
          BlocProvider(create: (_) => MonitorBloc()),
          BlocProvider(create: (_) => MonitorShoesBloc()),
          BlocProvider(create: (_) => MonitorClocksBloc()),
        ],
        child: IndexedStack(index: _currentScreen, children: [
          MySecondScreen(),
          MyThirdScreen(),
          MyFourthScreen(),
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("MENU"),
            ),
            ListTile(
              title: const Text("Sapatos"),
              onTap: () {
                setState(() {
                  _currentScreen = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Acessórios"),
              onTap: () {
                setState(() {
                  _currentScreen = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text("Meu carrinho"),
              onTap: () {
                setState(() {
                  _currentScreen = 2;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
