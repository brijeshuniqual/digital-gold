class NewUserModel {
  int? id;
  String? userUniqueId;
  String? name;
  String? email;
  String? profilePic;
  bool? isNotificationOn;
  bool? isFirstTimeUser;
  bool? isBlocked;
  String? language;
  int? verifiedAt;
  int? createdAt;
  Authentication? authentication;

  NewUserModel(
      {this.id,
        this.userUniqueId,
        this.name,
        this.email,
        this.profilePic,
        this.isNotificationOn,
        this.isFirstTimeUser,
        this.isBlocked,
        this.language,
        this.verifiedAt,
        this.createdAt,
        this.authentication});

  NewUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userUniqueId = json['userUniqueId'];
    name = json['name'];
    email = json['email'];
    profilePic = json['profilePic'];
    isNotificationOn = json['isNotificationOn'];
    isFirstTimeUser = json['isFirstTimeUser'];
    isBlocked = json['isBlocked'];
    language = json['language'];
    verifiedAt = json['verifiedAt'];
    createdAt = json['createdAt'];
    authentication = json['authentication'] != null
        ? Authentication.fromJson(json['authentication'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userUniqueId'] = userUniqueId;
    data['name'] = name;
    data['email'] = email;
    data['profilePic'] = profilePic;
    data['isNotificationOn'] = isNotificationOn;
    data['isFirstTimeUser'] = isFirstTimeUser;
    data['isBlocked'] = isBlocked;
    data['language'] = language;
    data['verifiedAt'] = verifiedAt;
    data['createdAt'] = createdAt;
    if (authentication != null) {
      data['authentication'] = authentication!.toJson();
    }
    return data;
  }
}

class Authentication {
  String? accessToken;
  String? refreshToken;
  int? expiresAt;

  Authentication({this.accessToken, this.refreshToken, this.expiresAt});

  Authentication.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['expiresAt'] = expiresAt;
    return data;
  }
}