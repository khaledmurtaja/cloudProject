class Training {
  final String id;
  final String name;
  final String category;
  final String description;
  final bool isPaidCourse;
  final List<Map<String, dynamic>> dates;
  final int price;
  final String imageUrl;
  final String advisorName;
  final String advisorId;

  Training({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.isPaidCourse,
    required this.dates,
    required this.price,
    required this.imageUrl,
    required this.advisorName,
    required this.advisorId,
  });

  factory Training.fromMap(Map<String, dynamic> data, String id) {
    final List<Map<String, dynamic>> dates =
        List<Map<String, dynamic>>.from(data['dates'] ?? []);
    return Training(
      id: id,
      name: data['trainingName'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      isPaidCourse: data['isPaidCourse'] ?? false,
      dates: dates,
      price: data['price'] ?? 0,
      imageUrl: data['courseImageUrl'] ?? '',
      advisorName: data['advisorName'] ?? '',
      advisorId: data['advisorId'] ?? '',
    );
  }
}
