class UserModel {
  final String titlename;
  final String firstname;
  final String lastname;
  final String country;
  final String city;
  final String latitude;
  final String longitude;
  final int age;
  final String phone;
  final String picture;

  UserModel(
      this.titlename,
      this.firstname,
      this.lastname,
      this.country,
      this.city,
      this.latitude,
      this.longitude,
      this.age,
      this.phone,
      this.picture);
  UserModel.fromJson(Map<String, dynamic> json)
      : titlename = json['results'][0]['name']['title'],
        firstname = json['results'][0]['name']['first'],
        lastname = json['results'][0]['name']['last'],
        country = json['results'][0]['location']['country'],
        city = json['results'][0]['location']['city'],
        latitude = json['results'][0]['location']['coordinates']['latitude'],
        longitude = json['results'][0]['location']['coordinates']['longitude'],
        age = json['results'][0]['dob']['age'],
        phone = json['results'][0]['phone'],
        picture = json['results'][0]['picture']['large'];
}

class MyLocation {
  final String latitude;
  final String longitude;

  MyLocation(this.latitude, this.longitude);
  MyLocation.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];
}
