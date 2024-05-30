class CompanyRequest {
  final String name;
  final String description;
  final String password;
  final String email;

  CompanyRequest({
    required this.name,
    required this.description,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'email': email,
      'password': password,
    };
  }
}
