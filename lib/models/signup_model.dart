class SignUpRequestModel {
  String nombre;
  String correo;
  String contrasena;

  SignUpRequestModel(
      {required this.nombre, required this.correo, required this.contrasena});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nombre'] = nombre;
    data['correo'] = correo;
    data['contrasena'] = contrasena;
    return data;
  }
}

class SignUpResponseModel {
  int statusCode;
  String description;

  SignUpResponseModel({required this.statusCode, required this.description});

  factory SignUpResponseModel.fromJson(
      int statusCode, Map<String, dynamic> json) {
    return SignUpResponseModel(
      statusCode: statusCode,
      description: json["description"],
    );
  }
}
