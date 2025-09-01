class WalletGroup {
  final String name;
  final List<WalletAccount> accounts;

  const WalletGroup({
    required this.name,
    required this.accounts,
  });
}

class WalletAccount {
  final String name;
  final String address;
  final String balance;

  const WalletAccount({
    required this.name,
    required this.address,
    required this.balance,
  });
}
