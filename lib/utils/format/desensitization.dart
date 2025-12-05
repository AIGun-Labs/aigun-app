///

///

String desensitization(
  String? address, {
  int prefixLength = 6,
  int suffixLength = 4,
}) {
  if (address == null || address.isEmpty) {
    return '';
  }

  if (prefixLength < 0) prefixLength = 6;
  if (suffixLength < 0) suffixLength = 4;

  final totalLength = prefixLength + suffixLength;
  if (address.length <= totalLength) {
    return address;
  }

  final first = address.substring(0, prefixLength);
  final last = address.substring(address.length - suffixLength);
  return '$first...$last';
}

String smartdesensitization(String? address) {
  if (address == null || address.isEmpty) {
    return '';
  }

  if (address.length <= 10) {
    return address;
  } else if (address.length <= 20) {
    return desensitization(address, prefixLength: 6, suffixLength: 4);
  } else if (address.length <= 40) {
    return desensitization(address, prefixLength: 8, suffixLength: 6);
  } else {
    return desensitization(address, prefixLength: 10, suffixLength: 8);
  }
}

String textdesensitization(
  String? text, {
  int prefixLength = 3,
  int suffixLength = 2,
}) {
  if (text == null || text.isEmpty) {
    return '';
  }

  if (text.length <= prefixLength + suffixLength) {
    return text;
  }

  final first = text.substring(0, prefixLength);
  final last = text.substring(text.length - suffixLength);
  return '$first...$last';
}

String splitText(String text, {int splitLength = 10}) {
  if (text.length <= splitLength) {
    return text;
  }
  return '${text.substring(0, splitLength)}...';
}
