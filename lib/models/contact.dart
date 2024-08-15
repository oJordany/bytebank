class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact({
    required this.id,
    required this.name,
    required this.accountNumber,
  });

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }

  Contact.fromJson(Map<String, dynamic>json):
    id = json['id'] != null ? json['id'] : 0,
    name = json['name'],
    accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'accountNumber': accountNumber,
  };
}
