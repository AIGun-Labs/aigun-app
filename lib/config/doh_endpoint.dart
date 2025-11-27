class DohEndpoint {
  final String name; // 方便日志区分，比如 "google" / "cloudflare"
  final String baseUrl; // 如 https://dns.google/resolve
  final Map<String, String> headers;

  const DohEndpoint({
    required this.name,
    required this.baseUrl,
    this.headers = const {},
  });

  /// Google Public DNS JSON API
  factory DohEndpoint.google() {
    return const DohEndpoint(
      name: 'google',
      baseUrl: 'https://dns.google/resolve',
      headers: {
        'Accept': 'application/dns-json',
      },
    );
  }

  /// Cloudflare DNS JSON API
  factory DohEndpoint.cloudflare() {
    return const DohEndpoint(
      name: 'cloudflare',
      baseUrl: 'https://cloudflare-dns.com/dns-query',
      headers: {
        'Accept': 'application/dns-json',
      },
    );
  }

  /// AliDNS JSON API
  factory DohEndpoint.alidns() {
    return const DohEndpoint(
      name: 'alidns',
      baseUrl: 'https://dns.alidns.com/resolve',
      headers: {
        'Accept': 'application/dns-json',
      },
    );
  }
}
