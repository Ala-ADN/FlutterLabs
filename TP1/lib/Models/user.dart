class User {
  String? email;
  String? fullName;

  User({this.email, this.fullName});

  @override
  String toString() => 'User(email: ' + (email ?? '') + ', fullName: ' + (fullName ?? '') + ')';
}
