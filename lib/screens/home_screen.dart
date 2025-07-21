import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../models/item.dart';
import 'item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item>? items;
  bool isLoading = true;
  String searchQuery = '';
  String? selectedCategory;
  String sortBy = 'Recent';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    setState(() {
      items = MockDataService.getMockItems();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Item> filteredItems = [];
    if (items != null) {
      filteredItems = items!.where((item) {
        final titleMatch = item.title.toLowerCase().contains(
          searchQuery.toLowerCase(),
        );
        final descriptionMatch = item.description.toLowerCase().contains(
          searchQuery.toLowerCase(),
        );
        final categoryMatch =
            selectedCategory == null || item.category == selectedCategory;
        return (titleMatch || descriptionMatch) && categoryMatch;
      }).toList();

      if (sortBy == 'Recent') {
        filteredItems.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      } else if (sortBy == 'Oldest') {
        filteredItems.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home Feed')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          _buildFilterChips(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredItems.isEmpty
                ? Center(
                    child: Text(
                      'No items found.',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _loadItems,
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(item.imageUrl),
                              radius: 28,
                            ),
                            title: Text(item.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Chip(
                                      label: Text(item.category),
                                      backgroundColor: item.isFound
                                          ? Colors.green[100]
                                          : Colors.red[100],
                                      labelStyle: TextStyle(
                                        color: item.isFound
                                            ? Colors.green[800]
                                            : Colors.red[800],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.place,
                                      size: 16,
                                      color: Colors.blueGrey,
                                    ),
                                    Text(
                                      item.location,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${item.isFound ? 'Found' : 'Lost'} • ${item.dateTime.toLocal().toString().split(' ')[0]}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
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
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final categories = [
      'All',
      'Wallet',
      'Keys',
      'Phone',
      'Book',
      'Bag',
      'ID Card',
      'Other',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((c) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(c),
                      selected:
                          selectedCategory == c ||
                          (c == 'All' && selectedCategory == null),
                      onSelected: (selected) {
                        setState(
                          () => selectedCategory = selected
                              ? (c == 'All' ? null : c)
                              : null,
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => sortBy = value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Recent',
                child: Text('Sort by Recent'),
              ),
              const PopupMenuItem(
                value: 'Oldest',
                child: Text('Sort by Oldest'),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
