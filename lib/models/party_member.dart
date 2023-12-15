class PartyMember {
  final String name;
  final String avatarUrl;
  final String klass;

  PartyMember({
    required this.name,
    required this.avatarUrl,
    required this.klass,
  });

  @override
  String toString() {
    return 'PartyMember{name: $name, avatarUrl: $avatarUrl, klass: $klass}';
  }
}
