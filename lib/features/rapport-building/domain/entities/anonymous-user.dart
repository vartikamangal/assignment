//! User class to be modified
import 'package:flutter/cupertino.dart';

abstract class User {
  final String userId;
  final String userName;

  User({
    @required this.userId,
    @required this.userName,
  });
}

class AnonymousUser extends User {
  @override
  final String userId;
  final String userName;

  AnonymousUser({@required this.userId, @required this.userName})
      : super(
          userId: userId,
          userName: userName,
        );
}
