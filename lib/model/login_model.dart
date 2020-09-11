class Login {
  Login({
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  });

  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json["username"],
        password: json["password"],
        salt: json["salt"],
        md5: json["md5"],
        sha1: json["sha1"],
        sha256: json["sha256"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "salt": salt,
        "md5": md5,
        "sha1": sha1,
        "sha256": sha256,
      };
}
