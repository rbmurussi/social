import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/shared/models/user.dart';

class UserTitleWidget extends StatelessWidget {

  final User user;
  UserTitleWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: NetworkImage('http://lorempixel.com.br/300/300?user-${user.id}'),
        ),
        SizedBox(width: 16),
        Text(user.name, style: TextStyle(fontSize: 20))
      ],
    );
  }
}
