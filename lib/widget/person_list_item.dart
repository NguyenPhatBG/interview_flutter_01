import 'package:flutter/material.dart';
import 'package:interview_flutter/models/person.dart';

import 'person_avatar.dart';

class PersonListItem extends StatelessWidget {
  const PersonListItem({required this.person, super.key});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/second', arguments: person);
          },
          leading: PersonAvatar(imageUrl: person.image!),
          title: Text(person.fullName()),
          subtitle: Text(person.email!),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          dense: true,
        ),
      ),
    );
  }
}
