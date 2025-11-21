class DomainConfig {
  // 生产环境备选域名列表
  static const List<String> prodDomains = [
    'https://api.route.aigun.ai',
    'https://api.main.com/v1', // 主域名
    'https://api.backup1.com/v1', // 备用 1
    'https://api.backup2.com/v1', // 备用 2 (比如 Cloudflare CDN 域名)
    'https://api.direct-ip.com/v1', // 备用 3 (直接 IP，防止 DNS 污染)
  ];

  // 开发环境
  static const List<String> devDomains = [
    'https://api.main.com/v1', // 主域名
    'https://api.backup1.com/v1', // 备用 1
    'https://api.backup2.com/v1', // 备用 2 (比如 Cloudflare CDN 域名)
    'https://api.direct-ip.com/v1', // 备用 3 (直接 IP，防止 DNS 污染)
    'https://t-api.route.aigun.ai',
    'https://api.dev.com/v1',
  ];
}
