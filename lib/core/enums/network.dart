enum Network {
  solana('solana'),
  eth('eth'),
  bsc('bsc'),
  base('base');

  final String value;

  const Network(this.value); // Remove the {} and required keyword
}
