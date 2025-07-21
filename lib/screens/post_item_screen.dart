import 'package:flutter/material.dart';

class PostItemScreen extends StatefulWidget {
  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String category = 'Wallet';
  String? imageUrl;
  String location = '';
  DateTime? dateTime;
  String contactMethod = 'In-app chat';

  final List<String> categories = [
    'Wallet',
    'Keys',
    'Phone',
    'Book',
    'Bag',
    'ID Card',
    'Other',
  ];
  final List<String> contactMethods = ['In-app chat', 'Phone', 'Email'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Lost/Found Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                onChanged: (v) => setState(() => title = v),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                onChanged: (v) => setState(() => description = v),
                validator: (v) => v == null || v.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: category,
                items: categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => category = v ?? category),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl!)
                        : null,
                    child: imageUrl == null
                        ? const Icon(Icons.camera_alt, size: 32)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Photo'),
                    onPressed: () {
                      setState(() {
                        imageUrl =
                            'https://via.placeholder.com/150'; // Mock upload
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.place),
                ),
                onChanged: (v) => setState(() => location = v),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dateTime == null
                          ? 'No date selected'
                          : 'Date: ${dateTime!.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Pick Date'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => dateTime = picked);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: contactMethod,
                items: contactMethods
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => contactMethod = v ?? contactMethod),
                decoration: InputDecoration(
                  labelText: 'Contact Method',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.contact_mail),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mock: Item posted!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
