import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../models/user_profile.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int? selectedChatIndex;
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [
    {'from': 'me', 'text': 'Hi, did you find my wallet?'},
    {'from': 'them', 'text': 'Yes, I found it near the cafeteria.'},
    {'from': 'me', 'text': 'Thank you! How can I claim it?'},
    {'from': 'them', 'text': 'Let’s meet at the library.'},
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({'from': 'me', 'text': text});
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = MockDataService.getMockUsers();
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: selectedChatIndex == null
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
                  title: Text(user.name),
                  subtitle: Text('Tap to chat...'),
                  onTap: () => setState(() => selectedChatIndex = index),
                );
              },
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[messages.length - 1 - index];
                      final isMe = msg['from'] == 'me';
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(msg['text']!),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(hintText: 'Type a message...'),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to chats'),
                  onPressed: () => setState(() => selectedChatIndex = null),
                ),
              ],
            ),
    );
  }
}
