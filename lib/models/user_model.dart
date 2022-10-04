
class UserModel {
  late String id;
  late String? name;
  late String? phone;
  late String? email;
  late String? password;

  UserModel({
    this.id = 'userId',
    this.name,
    this.phone,
    this.email,
    this.password,
  });
}
