String getOutputMint(String network) {
  switch (network) {
    case "solana":
      return "11111111111111111111111111111111";
    default:
      return "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";
  }
}
