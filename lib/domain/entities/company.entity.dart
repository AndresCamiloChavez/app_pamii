class Company {
  final int id;
  final String name;
  final String description;
  final String urlLogo;
  final String urlFrontPage;
  final String address;
  final bool isActive;
  final String email;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.urlLogo,
    required this.urlFrontPage,
    required this.address,
    required this.isActive,
    required this.email,
  });
}

class CompanyModel extends Company {
  CompanyModel({
    required super.id,
    required super.name,
    required super.description,
    required super.urlLogo,
    required super.urlFrontPage,
    required super.address,
    required super.isActive,
    required super.email,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      urlLogo: json['urlLogo'],
      urlFrontPage: json['urlFrontPage'],
      address: json['address'],
      isActive: json['isActive'],
      email: json['email'],
    );
  }
}