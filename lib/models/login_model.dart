// class LoginModel {
//   final String? status;
//   final int? attempts;
//   final int? limit;
//
//   LoginModel({
//     this.status,
//     this.attempts,
//     this.limit,
//   });
//
//   factory LoginModel.fromJson(Map<String, dynamic> json) {
//     return LoginModel(
//       status: json['status']?.toString(),
//       attempts: json['attempts'] is int
//           ? json['attempts']
//           : int.tryParse(json['attempts']?.toString() ?? ''),
//       limit: json['limit'] is int
//           ? json['limit']
//           : int.tryParse(json['limit']?.toString() ?? ''),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'attempts': attempts,
//       'limit': limit,
//     };
//   }
// }

class LoginModel {
  String status;
  int attempts;
  int limit;

  LoginModel({
    required this.status,
    required this.attempts,
    required this.limit,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      attempts: json['attempts'],
      limit: json['limit'],
    );
  }
}