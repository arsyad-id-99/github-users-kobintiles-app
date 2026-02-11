class User {
  int? id;
  String username;
  String avatarUrl;
  String? url;
  String? name;
  String? location;
  int? followers;

  User({
    this.id,
    required this.username,
    required this.avatarUrl,
    this.url,
    this.name,
    this.location,
    this.followers,
  });

  factory User.fromJsonList(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['login'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
    );
  }

  factory User.fromJsonDetail(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['login'],
      avatarUrl: json['avatar_url'],
      name: json['name'],
      location: json['location'],
      url: json['url'],
      followers: json['followers'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatarUrl': avatarUrl,
      'name': name,
      'location': location,
      'url': url,
      'followers': followers,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      avatarUrl: map['avatarUrl'],
      name: map['name'],
      location: map['location'],
      url: map['url'],
      followers: map['followers'],
    );
  }
}
