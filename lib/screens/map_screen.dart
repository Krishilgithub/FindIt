import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../models/item.dart';
import 'item_details_screen.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = MockDataService.getMockItems();
    return Scaffold(
      appBar: AppBar(title: const Text('Map View')),
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.blueGrey[100],
            child: const Center(
              child: Text('Map Placeholder', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(
                    item.isFound ? Icons.location_on : Icons.help_outline,
                    color: item.isFound ? Colors.green : Colors.red,
                  ),
                  title: Text(item.title),
                  subtitle: Text('Location: ${item.location}'),
                  trailing: Text(
                    item.isFound ? 'Found' : 'Lost',
                    style: TextStyle(
                      color: item.isFound ? Colors.green : Colors.red,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemDetailsScreen(item: item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
