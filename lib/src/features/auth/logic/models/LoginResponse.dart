class LoginResponse {
  int? status;
  UserInfo? userInfo;

  LoginResponse({status, userInfo});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? email;
  String? mobile;
  String? emailVerifiedAt;
  String? mobileVerifiedAt;
  String? authCode;
  int? verified;
  int? userType;
  int? status;
  String? lastLoginTime;
  String? lastLoginIpAddr;
  String? loginStatus;
  int? createdBy;
  String? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? token;
  RoleInfo? roleInfo;

  UserInfo(
      {id,
      email,
      mobile,
      emailVerifiedAt,
      mobileVerifiedAt,
      authCode,
      verified,
      userType,
      status,
      lastLoginTime,
      lastLoginIpAddr,
      loginStatus,
      createdBy,
      updatedBy,
      deletedAt,
      createdAt,
      updatedAt,
      token,
      roleInfo});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    mobileVerifiedAt = json['mobile_verified_at'];
    authCode = json['auth_code'];
    verified = json['verified'];
    userType = json['user_type'];
    status = json['status'];
    lastLoginTime = json['last_login_time'];
    lastLoginIpAddr = json['last_login_ip_addr'];
    loginStatus = json['login_status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    roleInfo =
        json['role_info'] != null ? RoleInfo.fromJson(json['role_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['mobile'] = mobile;
    data['email_verified_at'] = emailVerifiedAt;
    data['mobile_verified_at'] = mobileVerifiedAt;
    data['auth_code'] = authCode;
    data['verified'] = verified;
    data['user_type'] = userType;
    data['status'] = status;
    data['last_login_time'] = lastLoginTime;
    data['last_login_ip_addr'] = lastLoginIpAddr;
    data['login_status'] = loginStatus;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    if (roleInfo != null) {
      data['role_info'] = roleInfo!.toJson();
    }
    return data;
  }
}

class RoleInfo {
  int? id;
  int? userId;
  int? roleId;
  RoleDtlInfo? roleDtlInfo;
  List<RoleAccesses>? roleAccesses;

  RoleInfo({id, userId, roleId, roleDtlInfo, roleAccesses});

  RoleInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    roleId = json['role_id'];
    roleDtlInfo = json['role_dtl_info'] != null
        ? RoleDtlInfo.fromJson(json['role_dtl_info'])
        : null;
    if (json['role_accesses'] != null) {
      roleAccesses = <RoleAccesses>[];
      json['role_accesses'].forEach((v) {
        roleAccesses!.add(RoleAccesses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['role_id'] = roleId;
    if (roleDtlInfo != null) {
      data['role_dtl_info'] = roleDtlInfo!.toJson();
    }
    if (roleAccesses != null) {
      data['role_accesses'] = roleAccesses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RoleDtlInfo {
  int? id;
  String? roleTitle;
  int? weight;
  int? status;
  int? createdBy;
  int? updatedBy;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  RoleDtlInfo(
      {id,
      roleTitle,
      weight,
      status,
      createdBy,
      updatedBy,
      deletedAt,
      createdAt,
      updatedAt});

  RoleDtlInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleTitle = json['role_title'];
    weight = json['weight'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_title'] = roleTitle;
    data['weight'] = weight;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class RoleAccesses {
  int? id;
  int? roleId;
  int? featureId;
  int? create;
  int? viewOthers;
  int? edit;
  int? editOthers;
  int? delete;
  int? deleteOthers;

  RoleAccesses(
      {id,
      roleId,
      featureId,
      create,
      viewOthers,
      edit,
      editOthers,
      delete,
      deleteOthers});

  RoleAccesses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    featureId = json['feature_id'];
    create = json['create'];
    viewOthers = json['view_others'];
    edit = json['edit'];
    editOthers = json['edit_others'];
    delete = json['delete'];
    deleteOthers = json['delete_others'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['role_id'] = roleId;
    data['feature_id'] = featureId;
    data['create'] = create;
    data['view_others'] = viewOthers;
    data['edit'] = edit;
    data['edit_others'] = editOthers;
    data['delete'] = delete;
    data['delete_others'] = deleteOthers;
    return data;
  }
}
