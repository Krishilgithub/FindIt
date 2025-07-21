import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Map<String, String>> mockNotifications = [
    {
      'title': 'New Match Found!',
      'body': 'A found wallet matches your lost item post.',
    },
    {
      'title': 'Claim Update',
      'body': 'Your claim for "Found Keys" was approved.',
    },
    {'title': 'New Message', 'body': 'You have a new message from Bob.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        itemCount: mockNotifications.length,
        separatorBuilder: (context, i) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notif = mockNotifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications_active, color: Colors.blue),
            title: Text(notif['title']!),
            subtitle: Text(notif['body']!),
            trailing: const Icon(Icons.chevron_right),
          );
        },
      ),
    );
  }
}
