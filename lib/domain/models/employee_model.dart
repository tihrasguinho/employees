import 'dart:convert';

class EmployeeModel {
  final String id;
  final String name;
  final String job;
  final DateTime admissionDate;
  final String phone;
  final String image;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.job,
    required this.admissionDate,
    required this.phone,
    required this.image,
  });

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? job,
    DateTime? admissionDate,
    String? phone,
    String? image,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      job: job ?? this.job,
      admissionDate: admissionDate ?? this.admissionDate,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'job': job,
      'admission_date': admissionDate.toIso8601String(),
      'phone': phone,
      'image': image,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as String,
      name: map['name'] as String,
      job: map['job'] as String,
      admissionDate: DateTime.parse(map['admission_date'] as String),
      phone: map['phone'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, job: $job, admissionDate: $admissionDate, phone: $phone, image: $image)';
  }

  @override
  bool operator ==(covariant EmployeeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.job == job &&
        other.admissionDate == admissionDate &&
        other.phone == phone &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        job.hashCode ^
        admissionDate.hashCode ^
        phone.hashCode ^
        image.hashCode;
  }
}
