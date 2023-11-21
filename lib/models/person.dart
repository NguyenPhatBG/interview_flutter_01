class Person {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? birthday;
  String? gender;
  Address? address;
  String? website;
  String? image;

  Person(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.birthday,
      this.gender,
      this.address,
      this.website,
      this.image});

  String fullName() {
    return '$firstname $lastname';
  }

  String location() {
    return 'Latitude(${address!.latitude}), Longitude(${address!.longitude})';
  }

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    birthday = json['birthday'];
    gender = json['gender'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    website = json['website'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phone'] = phone;
    data['birthday'] = birthday;
    data['gender'] = gender;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['website'] = website;
    data['image'] = image;
    return data;
  }
}

class Address {
  int? id;
  String? street;
  String? streetName;
  String? buildingNumber;
  String? city;
  String? zipcode;
  String? country;
  String? countyCode;
  double? latitude;
  double? longitude;

  Address(
      {this.id,
      this.street,
      this.streetName,
      this.buildingNumber,
      this.city,
      this.zipcode,
      this.country,
      this.countyCode,
      this.latitude,
      this.longitude});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    streetName = json['streetName'];
    buildingNumber = json['buildingNumber'];
    city = json['city'];
    zipcode = json['zipcode'];
    country = json['country'];
    countyCode = json['county_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['street'] = street;
    data['streetName'] = streetName;
    data['buildingNumber'] = buildingNumber;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['country'] = country;
    data['county_code'] = countyCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
