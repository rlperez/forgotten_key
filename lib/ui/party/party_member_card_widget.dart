import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forgotten_key/models/party_member.dart';

class PartyMemberCardWidget extends StatelessWidget {
  final PartyMember member;

  const PartyMemberCardWidget({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          width: 300,
          height: 100,
          child: Center(
              child: Column(children: [
            Text(member.name.replaceAll("\x00", '')),
            Image.file(File('test/data/000000024-BarbToDruid/PORTRT0.bmp')),
          ])),
        ),
      ),
    );
  }
}
