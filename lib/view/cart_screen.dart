import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/manage_bloc.dart';
import '../../bloc/manage_event.dart';
import '../../bloc/monitor_state.dart';
import '../../bloc/monitor_bloc.dart';
import '../model/items.dart';

class MyFourthScreen extends StatefulWidget {
  MyFourthScreen({Key? key}) : super(key: key);

  @override
  _MyFourthScreenState createState() => _MyFourthScreenState();
}

class _MyFourthScreenState extends State<MyFourthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) => getItemListView(state.itemCollection, context));
  }
}

Widget getItemListView(ItemCollection itemCollection, context) {
  final List icons = [
    Icons.access_alarm,
    Icons.access_alarm_rounded
  ];

  return Column(children: [
    const Center(
        child: Text(" MEU CARRINHO ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ))),
    const Divider(
      thickness: 3,
    ),
    Expanded(
      child: ListView.builder(
          itemCount: itemCollection.length(),
          itemBuilder: (context, position) => ListTile(
                leading: (itemCollection.getNodeAtIndex(position).image != ""
                    ? ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
                        child: (itemCollection.getNodeAtIndex(position).image != "") ? ConstrainedBox(constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300), child: Image.network(itemCollection.getNodeAtIndex(position).image)) : Icon(icons[position % icons.length]),
                      )
                    : const Icon(
                        Icons.access_alarm_rounded,
                      )),
                trailing: GestureDetector(
                    onTap: () {
                      BlocProvider.of<ManageBloc>(context).add(DeleteEvent(itemId: itemCollection.getIdAtIndex(position)));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                        content: Text("Item removido do carrinho"),
                      ));
                    },
                    child: const Icon(Icons.delete)),
                title: Text(itemCollection.getNodeAtIndex(position).brand + " " + itemCollection.getNodeAtIndex(position).name),
                subtitle: Text("Code:" + itemCollection.getNodeAtIndex(position).code.toString() + " \nR\$: " + itemCollection.getNodeAtIndex(position).price.toStringAsFixed(2)),
              )),
    ),
    Center(
        child: Text("Total: R\$ " + itemCollection.getTotal().toStringAsFixed(2) + "\n",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ))),
    ElevatedButton(
        child: const Text("FINALIZAR"),
        onPressed: () {
          for (int i = 0; i < itemCollection.length(); i++) {
            BlocProvider.of<ManageBloc>(context).add(DeleteEvent(itemId: itemCollection.getIdAtIndex(i)));
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
            content: Text("Compra efetuada com sucesso!"),
          ));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
    const Text("\n"),
  ]);
}
