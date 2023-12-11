import 'package:flutter/material.dart';
import 'package:forgotten_key/models/party_member.dart';
import 'package:forgotten_key/ui/party/party_member_card_widget.dart';

class PartyGridWidget extends StatelessWidget {
  final List<PartyMember> members;

  const PartyGridWidget({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: members.length,
      itemBuilder: (context, index) {
        print("FFFFFFFFFFFFFFFFFFFF $index");
        return PartyMemberCardWidget(member: members[index]);
      },
    ));
  }
}
