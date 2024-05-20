class Service {
  final int id;
  final String name;
  final String description;
  final String genericPhoto;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.genericPhoto,
  });
}

class ServiceModel extends Service {
  ServiceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.genericPhoto,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      genericPhoto: json['genericPhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'genericPhoto': genericPhoto,
    };
  }
}
