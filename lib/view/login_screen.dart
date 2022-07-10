import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class MyFirstScreen extends StatefulWidget {
  const MyFirstScreen({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyFirstScreenState createState() => _MyFirstScreenState();
}

class _MyFirstScreenState extends State<MyFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return loginScreen(context);
  }
}

Widget loginScreen(context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String emailAddress = "";
  String password = "";

  return ListView(children: [
    Form(
      key: formKey,
      child: Column(children: [
        Container(
          child: ClipRRect(
              child: Image.asset(
            'assets/images/ICS-Logo.png',
            width: 350,
          )),
          padding: EdgeInsets.all(25.0),
        ),
        const Text("LOGIN", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const Divider(
          thickness: 3,
        ),
        //USUARIO
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (String? inValue) {
            if (inValue != null) {
              if (inValue.isEmpty) {
                return "Insira um e-mail";
              }
            }
            return null;
          },
          onSaved: (String? inValue) {
            emailAddress = inValue!;
          },
          decoration: const InputDecoration(
            hintText: "user@domain.br",
            labelText: "E-mail Address",
          ),
        ),
        //PASSWORD
        TextFormField(
          obscureText: true,
          validator: (String? inValue) {
            if (inValue != null) {
              if (inValue.isEmpty) {
                return "Insira uma senha";
              }
            }
            if (inValue!.length < 6) {
              return "Senha deve ter ao menos 6 caracters";
            }
            return null;
          },
          onSaved: (String? inValue) {
            password = inValue!;
          },
          decoration: const InputDecoration(
            labelText: "Password",
          ),
        ),
        const Divider(
          thickness: 3,
          color: Colors.white,
        ),
        //SUBMIT BUTTON
        ElevatedButton(
          child: const Text("ENTRAR"),
          onPressed: () {
            formKey.currentState!.save();
            // Lançando evento
            BlocProvider.of<AuthBloc>(context).add(LoginUser(emailAddress: emailAddress, password: password));
            //
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              content: const Text("Login efetuado com sucesso!"),
            ));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Text("\n")
      ]),
    ),
  ]);
}
