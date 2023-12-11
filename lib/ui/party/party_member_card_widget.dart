import 'package:flutter/material.dart';
import 'package:forgotten_key/models/party_member.dart';

class PartyMemberCardWidget extends StatelessWidget {
  final PartyMember member;

  const PartyMemberCardWidget({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 260,
        child: Card(
            child: Column(
          children: [
            Text("$member"),
          ],
        )));
  }
}
