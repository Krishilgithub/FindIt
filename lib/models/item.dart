class Item {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String location;
  final DateTime dateTime;
  final String contactMethod;
  final bool isFound;
  final String userId;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.location,
    required this.dateTime,
    required this.contactMethod,
    required this.isFound,
    required this.userId,
  });
}
