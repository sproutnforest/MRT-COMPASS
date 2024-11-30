import 'package:flutter/material.dart';
import 'package:mrt/constant.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: ListView.builder(
        itemCount: 5, // Jumlah tiket
        itemBuilder: (context, index) => TicketItem(index: index),
      ),
    );
  }
}

class TicketItem extends StatelessWidget {
  final int index;

  const TicketItem({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Ticket $index"),
    );
  }
}