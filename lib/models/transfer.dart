class Transfer {
  final double value;
  final int accountNumber;

  Transfer({required this.value, required this.accountNumber});

  @override
  String toString() {
    return 'Transferencia{value: $value, accountNumber: $accountNumber}';
  }
}