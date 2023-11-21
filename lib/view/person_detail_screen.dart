import 'package:flutter/material.dart';

import '../models/person.dart';
import '../widget/person_avatar.dart';
import '../widget/person_item.dart';

class PersonDetailScreen extends StatelessWidget {
  const PersonDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Person;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.fullName()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            key: ValueKey(args.id),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: PersonAvatar(imageUrl: args.image!),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PersonItem(title: 'Birthday', content: args.birthday!),
                      PersonItem(title: 'Gender', content: args.gender!),
                      PersonItem(title: 'Email', content: args.email!),
                      PersonItem(title: 'Phone', content: args.phone!),
                      PersonItem(title: 'Website', content: args.website!),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    text: args.fullName(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                          text: "'s address information!",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    key: ValueKey(args.address?.id),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PersonItem(
                          title: 'Country', content: args.address!.country!),
                      PersonItem(title: 'City', content: args.address!.city!),
                      PersonItem(
                          title: 'Street', content: args.address!.street!),
                      PersonItem(
                        title: 'Street Name',
                        content: args.address!.streetName!,
                      ),
                      PersonItem(
                        title: 'Country Code',
                        content: args.address!.countyCode!,
                      ),
                      PersonItem(
                          title: 'Zipcode', content: args.address!.zipcode!),
                      PersonItem(
                        title: 'Building Number',
                        content: args.address!.buildingNumber!,
                      ),
                      PersonItem(
                        title: 'Location',
                        content: args.location(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
