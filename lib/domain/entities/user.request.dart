class UserRequest {
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String email;
  final String birthDay;

  UserRequest({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.birthDay,
    required this.email,
  });
}