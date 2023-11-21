import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:interview_flutter/models/person.dart';

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
            Navigator.pushNamed(context, '/second');
          },
          leading: CachedNetworkImage(
            imageUrl: person.image!,
            placeholder: (context, url) => const CircularProgressIndicator(
              strokeWidth: 1,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text('${person.firstname!} ${person.lastname!}'),
          subtitle: Text(person.email!),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          dense: true,
        ),
      ),
    );
  }
}
