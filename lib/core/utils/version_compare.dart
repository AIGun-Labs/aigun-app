int compareSemver(String a, String b) {
  List<int> pa = a
      .split('-')
      .first
      .split('.')
      .map((e) => int.tryParse(e) ?? 0)
      .toList();
  List<int> pb = b
      .split('-')
      .first
      .split('.')
      .map((e) => int.tryParse(e) ?? 0)
      .toList();
  for (var i = 0; i < 3; i++) {
    final d = (pa.length > i ? pa[i] : 0) - (pb.length > i ? pb[i] : 0);
    if (d != 0) return d;
  }
  return 0;
}
