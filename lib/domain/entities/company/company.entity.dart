class CompanyResponse {
    String name;
    String description;
    bool isActive;
    String email;
    Role role;
    dynamic urlLogo;
    dynamic urlFrontPage;
    dynamic address;
    int id;

    CompanyResponse({
        required this.name,
        required this.description,
        required this.isActive,
        required this.email,
        required this.role,
        required this.urlLogo,
        required this.urlFrontPage,
        required this.address,
        required this.id,
    });

    factory CompanyResponse.fromJson(Map<String, dynamic> json) => CompanyResponse(
        name: json["name"],
        description: json["description"],
        isActive: json["isActive"],
        email: json["email"],
        role: Role.fromJson(json["role"]),
        urlLogo: json["urlLogo"],
        urlFrontPage: json["urlFrontPage"],
        address: json["address"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "isActive": isActive,
        "email": email,
        "role": role.toJson(),
        "urlLogo": urlLogo,
        "urlFrontPage": urlFrontPage,
        "address": address,
        "id": id,
    };
}

class Role {
    int id;
    String name;

    Role({
        required this.id,
        required this.name,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
