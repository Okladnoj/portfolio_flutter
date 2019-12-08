class UserModel {
  final String name;
  final String profileimage;
  final String pictureurl;
  final String altdescription;
  final String pictureurllag;

  const UserModel({
    this.name,
    this.profileimage,
    this.pictureurl,
    this.altdescription,
    this.pictureurllag,
  });

  factory UserModel.fromJson({int i, List<dynamic> json}) {
    return UserModel(
        name: json[i]['user']['name'],
        profileimage: i == 0
            ? json[i]['sponsorship']['sponsor']['profile_image']['large']
            : json[i]['user']['profile_image']['large'],
        pictureurl: json[i]['urls']['thumb'],
        pictureurllag: json[i]['urls']['regular'],
        altdescription: json[i]['alt_description'] == null
            ? json[i]['description'] == null
                ? 'Автор не дал названия'
                : json[i]['description']
            : json[i]['alt_description']);
  }
}
