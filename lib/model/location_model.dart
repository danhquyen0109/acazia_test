class Location {
  Location({
    this.street,
    this.city,
    this.state,
    this.postcode,
  });

  String street;
  String city;
  String state;
  int postcode;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "postcode": postcode,
      };
}
