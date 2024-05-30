class UserRequest {
    String firstName;
    String lastName;
    String phone;
    String password;
    String email;
    String birthDay;

    UserRequest({
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.password,
        required this.email,
        required this.birthDay,
    });

    factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        password: json["password"],
        email: json["email"],
        birthDay: json["birthDay"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "password": password,
        "email": email,
        "birthDay": birthDay,
    };
}

class UserRegisterResponse {
    String firstName;
    String lastName;
    String phone;
    String email;
    String birthDay;
    bool isActive;
    dynamic resetCode;
    dynamic resetCodeTimestamp;
    int id;

    UserRegisterResponse({
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
        required this.birthDay,
        required this.isActive,
        required this.resetCode,
        required this.resetCodeTimestamp,
        required this.id,
    });

    factory UserRegisterResponse.fromJson(Map<String, dynamic> json) => UserRegisterResponse(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        birthDay: json["birthDay"],
        isActive: json["isActive"],
        resetCode: json["resetCode"],
        resetCodeTimestamp: json["resetCodeTimestamp"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "birthDay": birthDay,
        "isActive": isActive,
        "resetCode": resetCode,
        "resetCodeTimestamp": resetCodeTimestamp,
        "id": id,
    };
}


class LoginUserResponse {
    LoginUserResponse user;
    String token;

    LoginUserResponse({
        required this.user,
        required this.token,
    });

    factory LoginUserResponse.fromJson(Map<String, dynamic> json) => LoginUserResponse(
        user: LoginUserResponse.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    int id;
    String firstName;
    String lastName;
    String phone;
    String email;
    String birthDay;
    bool isActive;
    String resetCode;
    String resetCodeTimestamp;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.email,
        required this.birthDay,
        required this.isActive,
        required this.resetCode,
        required this.resetCodeTimestamp,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        birthDay: json["birthDay"],
        isActive: json["isActive"],
        resetCode: json["resetCode"],
        resetCodeTimestamp: json["resetCodeTimestamp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "birthDay": birthDay,
        "isActive": isActive,
        "resetCode": resetCode,
        "resetCodeTimestamp": resetCodeTimestamp,
    };
}
