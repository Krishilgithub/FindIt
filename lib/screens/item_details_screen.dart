import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;
  const ItemDetailsScreen({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(item.imageUrl),
              radius: 60,
            ),
          ),
          const SizedBox(height: 16),
          Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Chip(
                label: Text(item.category),
                backgroundColor: item.isFound
                    ? Colors.green[100]
                    : Colors.red[100],
                labelStyle: TextStyle(
                  color: item.isFound ? Colors.green[800] : Colors.red[800],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.place, size: 18, color: Colors.blueGrey),
              Text(item.location, style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Text(item.description),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 18, color: Colors.blueGrey),
              const SizedBox(width: 6),
              Text('Date: ${item.dateTime.toLocal().toString().split(' ')[0]}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.contact_mail, size: 18, color: Colors.blueGrey),
              const SizedBox(width: 6),
              Text('Contact: ${item.contactMethod}'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Status: ${item.isFound ? 'Found' : 'Lost'}',
            style: TextStyle(
              color: item.isFound ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.assignment_turned_in),
            label: const Text('Claim / Request Item'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mock: Claim/Request sent!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
