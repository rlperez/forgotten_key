import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forgotten_key/models/party_member.dart';

class PartyNavigationRail extends StatefulWidget {
  final List<PartyMember> members;

  const PartyNavigationRail({super.key, required this.members});

  @override
  State<PartyNavigationRail> createState() => _PartyNavigationRailState();
}

class _PartyNavigationRailState extends State<PartyNavigationRail> {
  late final List<PartyMember> members;

  int _selectedIndex = 0;
  final NavigationRailLabelType _labelType = NavigationRailLabelType.all;
  final double _groupAlignment = -1.0;

  @override
  void initState() {
    super.initState();
    members = widget.members;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: _groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: _labelType,
              leading: const SizedBox(),
              trailing: const SizedBox(),
              destinations: members
                  .map((m) => NavigationRailDestination(
                        icon: Badge(
                          label: Image.file(File("")),
                          child: const Icon(Icons.star_border),
                        ),
                        selectedIcon: const Badge(
                          label: Text('4'),
                          child: Icon(Icons.star),
                        ),
                        label: const Text('Third'),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
