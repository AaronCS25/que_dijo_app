class LoginRequestModel {
  String correo;
  String contrasena;

  LoginRequestModel({required this.correo, required this.contrasena});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correo'] = correo;
    data['contrasena'] = contrasena;
    return data;
  }
}

class LoginResponseModel {
  int statusCode;
  String token;
  int userId;

  LoginResponseModel(
      {required this.statusCode, required this.token, required this.userId});

  factory LoginResponseModel.fromJson(int statusCode, Map<String, dynamic> json) {
    return LoginResponseModel(
        statusCode: statusCode,
        token: json['token'],
        userId: json['user'][0]);
  }
}
