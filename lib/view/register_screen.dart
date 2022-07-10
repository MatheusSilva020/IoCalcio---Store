import 'package:flutter/material.dart';
import 'package:calciostore/model/complete_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class MyFifthScreen extends StatefulWidget {
  const MyFifthScreen({Key? key}) : super(key: key);

  @override
  _MyFifthScreenState createState() => _MyFifthScreenState();
}

class _MyFifthScreenState extends State<MyFifthScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CompleteForm completeForm = CompleteForm();
  String emailAddress = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(children: [
                const Text("CADASTRO", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const Divider(
                  thickness: 3,
                ),
                //NAME
                TextFormField(
                  initialValue: completeForm.name,
                  validator: (String? inValue) {
                    if (inValue != null) {
                      if (inValue.isEmpty) {
                        return "Insira um nome";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    completeForm.name = value!;
                  },
                  decoration: const InputDecoration(
                    hintText: "Alfredo Chiesa",
                    labelText: "Nome completo",
                  ),
                ),
                //ADDRESS
                TextFormField(
                  initialValue: completeForm.address,
                  validator: (String? inValue) {
                    if (inValue != null) {
                      if (inValue.isEmpty) {
                        return "Insira um endereço";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    completeForm.address = value!;
                  },
                  decoration: const InputDecoration(
                    hintText: "Rua das Laranjeiras 324",
                    labelText: "Endereço",
                  ),
                ),
                //PHONE
                TextFormField(
                  initialValue: completeForm.phone,
                  validator: (String? inValue) {
                    if (inValue != null) {
                      if (inValue.isEmpty) {
                        return "Insira um Telefone";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    completeForm.phone = value!;
                  },
                  decoration: const InputDecoration(
                    hintText: "8888-8888",
                    labelText: "Telefone",
                  ),
                ),
                //EMAIL-USERNAME
                TextFormField(
                  initialValue: completeForm.emailAddress,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? inValue) {
                    if (inValue != null) {
                      if (inValue.isEmpty) {
                        return "Insira um nome de usuário";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    completeForm.emailAddress = value!;
                    emailAddress = value;
                  },
                  decoration: const InputDecoration(
                    hintText: "user@domain.br",
                    labelText: "Username (E-mail Address)",
                  ),
                ),
                //PASSWORD
                TextFormField(
                  initialValue: completeForm.password,
                  obscureText: true,
                  validator: (String? inValue) {
                    if (inValue != null) {
                      if (inValue.length < 6) {
                        return "Mínimo de 6 caracteres";
                      }
                    }
                    return null;
                  },
                  onSaved: (value) {
                    completeForm.password = value!;
                    password = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Insira uma senha",
                  ),
                ),
                const Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
                //GENDER SELECTION
                Row(children: [
                  Row(children: [
                    stateRadio(0),
                    Text("Masculino")
                  ]),
                  Row(children: [
                    stateRadio(1),
                    Text("Feminino")
                  ]),
                ]),
                const Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
                //SUBMIT BUTTON
                ElevatedButton(
                  child: const Text("CADASTRAR"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      //add ao firebase:
                      BlocProvider.of<RegisterBloc>(context).add(SubmitEvent(completeForm: completeForm));
                      //novo usuario:
                      BlocProvider.of<AuthBloc>(context).add(RegisterUser(emailAddress: emailAddress, password: password));
                      //snackbar:
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 5),
                        content: Text("Cadastro efetuado com sucesso!"),
                      ));
                      formKey.currentState!.reset();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),
            const Text("\n")
          ],
        ),
      );
    });
  }

  Widget stateRadio(int value) {
    return Radio(
        value: value,
        groupValue: completeForm.radioButtonGender,
        onChanged: (inValue) {
          setState(() => completeForm.radioButtonGender = inValue as int);
        });
  }
}
