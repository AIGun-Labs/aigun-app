enum ChainSymbol {
  solana('SOL'),
  bnb("BNB"),
  eth("ETH"),
  okb("OKB"),
  tron("TRON"),
  btc("BTC");

  const ChainSymbol(this.value);

  final String value;
}
