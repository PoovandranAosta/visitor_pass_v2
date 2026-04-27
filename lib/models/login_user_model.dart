class LoginUserModel {
  final int? iUserId;
  final String? cLogin;
  final int? iRoleId;
  final String? roleName;
  final String? userName;
  final int? iEmpId;
  final int? bGlobalUser;
  final String? photoPath;
  final String? photoLink;

  LoginUserModel({
    this.iUserId,
    this.cLogin,
    this.iRoleId,
    this.roleName,
    this.userName,
    this.iEmpId,
    this.bGlobalUser,
    this.photoPath,
    this.photoLink,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      iUserId: json['iUser_id'] is int
          ? json['iUser_id']
          : int.tryParse(json['iUser_id']?.toString() ?? ''),
      cLogin: json['cLogin']?.toString(),
      iRoleId: json['iRole_id'] is int
          ? json['iRole_id']
          : int.tryParse(json['iRole_id']?.toString() ?? ''),
      roleName: json['RoleName']?.toString(),
      userName: json['UserName']?.toString(),
      iEmpId: json['iEmp_id'] is int
          ? json['iEmp_id']
          : int.tryParse(json['iEmp_id']?.toString() ?? ''),
      bGlobalUser: json['bGlobal_User'] is int
          ? json['bGlobal_User']
          : int.tryParse(json['bGlobal_User']?.toString() ?? ''),
      photoPath: json['PhotoPath']?.toString(),
      photoLink: json['PhotoLink']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iUser_id': iUserId,
      'cLogin': cLogin,
      'iRole_id': iRoleId,
      'RoleName': roleName,
      'UserName': userName,
      'iEmp_id': iEmpId,
      'bGlobal_User': bGlobalUser,
      'PhotoPath': photoPath,
      'PhotoLink': photoLink,
    };
  }
}
