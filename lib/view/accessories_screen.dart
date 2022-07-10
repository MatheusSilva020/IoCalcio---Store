import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/manage_bloc.dart';
import '../../bloc/manage_event.dart';
import '../../bloc/monitor_clocks_state.dart';
import '../../bloc/monitor_clocks_bloc.dart';
import '../../model/items.dart';

class MyThirdScreen extends StatelessWidget {
  MyThirdScreen({Key? key}) : super(key: key);

  final List icons = [
    Icons.access_alarm,
    Icons.access_alarm_rounded
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorClocksBloc, MonitorClocksState>(builder: (context, state) => getClockListView(state.itemCollection, context));
  }

  Widget getClockListView(ItemCollection itemCollection, context) {
    return Column(children: [
      const Center(
          child: Text("\n ACESSÓRIOS ",
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
                    constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
                    child: (itemCollection.getNodeAtIndex(position).image != "") ? ConstrainedBox(constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300), child: Image.network(itemCollection.getNodeAtIndex(position).image)) : Icon(icons[position % icons.length]),
                  )
                : Icon(
                    icons[position % icons.length],
                  )),
            trailing: GestureDetector(
                onTap: () {
                  BlocProvider.of<ManageBloc>(context).add(SubmitEvent(item: itemCollection.getNodeAtIndex(position)));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                    content: const Text("Adicionado ao carrinho!"),
                  ));
                },
                child: const Icon(Icons.add_circle_outline_outlined)),
            title: Text("\n" + itemCollection.getNodeAtIndex(position).brand + " " + itemCollection.getNodeAtIndex(position).name),
            subtitle: Text("\nRelógio - R\$: " + itemCollection.getNodeAtIndex(position).price.toStringAsFixed(2) + "\nCode: " + itemCollection.getNodeAtIndex(position).code + "\n"),
          ),
        ),
      ),
    ]);
  }
}
