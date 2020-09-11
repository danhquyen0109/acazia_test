import 'package:acazia_test/model/location_model.dart';
import 'package:acazia_test/model/login_model.dart';
import 'package:acazia_test/model/picture_model.dart';

import '../utils/global.dart';

class User {
  User({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  });

  String gender;
  String name;
  Location location;
  String email;
  Login login;
  String dob;
  String registered;
  String phone;
  String cell;
  String id;
  Picture picture;
  String nat;

  factory User.fromJson(Map<String, dynamic> json) => User(
        gender: json["gender"],
        name: json["name"]["title"] +
            " " +
            json["name"]["first"] +
            " " +
            json["name"]["last"] +
            " " +
            random.nextInt(1000).toString(),
        location: Location.fromJson(json["location"]),
        email: json["email"],
        login: Login.fromJson(json["login"]),
        dob: json["dob"],
        registered: json["registered"],
        phone: json["phone"],
        cell: json["cell"],
        id: json["id"]["value"],
        picture: Picture.fromJson(json["picture"]),
        nat: json["nat"],
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "name": name,
        "location": location.toJson(),
        "email": email,
        "login": login.toJson(),
        "dob": dob,
        "registered": registered,
        "phone": phone,
        "cell": cell,
        "id": id,
        "picture": picture.toJson(),
        "nat": nat,
      };
}
