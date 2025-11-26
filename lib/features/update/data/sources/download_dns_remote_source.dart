import 'package:super_dns_client/super_dns_client.dart';

class DownloadDnsRemoteSource {
  final DnsOverHttps _dohClient;

  static const String _downloadDomain = 'download.route.aigun.ai';

  DownloadDnsRemoteSource({DnsOverHttps? dohClient})
      : _dohClient = dohClient ?? DnsOverHttps.cloudflare();

  /// 返回所有 CNAME 记录字符串
  Future<List<String>> getDownloadCnames() async {
    final results = await _dohClient.lookupDataByRRType(
      _downloadDomain,
      RRType.cname,
    );
    print('getDownloadCnames: $results');
    return results;
  }

  /// 返回第一个 CNAME（常见场景）
  Future<String?> getFirstDownloadCname() async {
    final list = await getDownloadCnames();
    if (list.isEmpty) return null;

    print('getFirstDownloadCname: ${list.first}');

    return list.first;
  }

  void dispose() {
    _dohClient.close();
  }
}
