class Face {
  final String id; // Changed from int to String
  final String name;
  final bool access;

  Face({required this.id, required this.name, required this.access});

  factory Face.fromMap(Map<String, dynamic> map) {
    return Face(
      id: map['id'], // No need to parse, it's already a String
      name: map['name'],
      access: map['access'] is bool ? map['access'] : map['access'] == 'true',
    );
  }
}
