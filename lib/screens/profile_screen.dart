import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../models/user_profile.dart';
import '../models/item.dart';
import 'item_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = MockDataService.getMockUsers().first;
    final items = MockDataService.getMockItems()
        .where((item) => item.userId == user.id)
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
                radius: 36,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(user.email, style: TextStyle(color: Colors.grey[700])),
                  Text(
                    'Role: ${user.role}',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('My Posts', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl),
                ),
                title: Text(item.title),
                subtitle: Text(
                  '${item.isFound ? 'Found' : 'Lost'} • ${item.dateTime.toLocal().toString().split(' ')[0]}',
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ItemDetailsScreen(item: item),
                    ),
                  );
                },
              ),
            ),
          ),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No posts yet.'),
            ),
          const SizedBox(height: 24),
          Text('Settings', style: Theme.of(context).textTheme.titleMedium),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Account Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
