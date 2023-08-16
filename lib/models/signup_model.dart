class SignUpModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? jenisKelamin;

  SignUpModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.jenisKelamin,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    jenisKelamin = json['jenisKelamin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] ??= id;
    data['name'] ??= name;
    data['email'] ??= email;
    data['password'] ??= password;
    data['jenisKelamin'] ??= jenisKelamin;
    return data;
  }
}
