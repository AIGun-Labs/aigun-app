///semver 版本号比较
///a 和 b 都是 semver 版本号
///返回值：
///-1：a 小于 b
///0：a 等于 b
///1：a 大于 b
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
