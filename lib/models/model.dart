class Student {
  final int? id;
  final String name;
  final int age;
  final int phone;

  Student({
    this.id,
    required this.phone,
    required this.name,
    required this.age,
  });
  copyWith({
    int? id,
    String? name,
    int? age,
    int? phone,
  }) {
    return Student(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        phone: phone ?? this.phone);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "phone": phone,
    };
  }
}
