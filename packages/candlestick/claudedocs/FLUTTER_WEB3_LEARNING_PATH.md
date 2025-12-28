
>  Web3 
> ：2025-12-23

---

****: Web3 
****:
-  Web3/
- 、、
- 

****:  Flutter + Web3 /

---

```
Phase 1: Flutter  (1-2)
    ↓
Phase 2:  (1-2)
    ↓
Phase 3:  (1-2)
    ↓
Phase 4: Web3  (2-3)
    ↓
Phase 5:  ()
```

---
```dart
Stream<int> countStream = Stream.periodic(
  Duration(seconds: 1),
  (x) => x,
).take(10);
await Isolate.spawn(heavyComputation, data);
extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
```

****:
- [ ] Stream （map、where、expand、asyncMap）
- [ ] Isolate  compute() 
- [ ] Extension methods
- [ ] Mixin 
- [ ] /
- [ ] （、）
- [Dart ](https://dart.dev/language)
- [Effective Dart](https://dart.dev/effective-dart)

---
```
Widget Tree → Element Tree → RenderObject Tree
   ()        ()        (/)
```

****:
- [ ] Widget 
- [ ] Element 
- [ ] RenderObject 
- [ ] Layer 
- [ ] Key 
1.  `StatefulWidget` ， `createElement()` 
2.  `ListView.builder` 
3.  RenderObject

---

****:
- [ ] CustomPaint  Canvas API
- [ ] GestureDetector 
- [ ] （CustomMultiChildLayout）
- [ ]  Sliver 
```dart
class CandlestickChart extends CustomPainter {
}
```

**， candlestick **

---
```dart
abstract class TradeEvent {}
class PlaceOrder extends TradeEvent {
  final Order order;
  PlaceOrder(this.order);
}

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  TradeBloc() : super(TradeInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<TradeState> emit,
  ) async {
    emit(TradeLoading());
    try {
      final result = await _tradeRepository.placeOrder(event.order);
      emit(TradeSuccess(result));
    } catch (e) {
      emit(TradeError(e.toString()));
    }
  }
}
```

****:
- [ ] Bloc vs Cubit 
- [ ] BlocObserver 
- [ ] MultiBlocProvider 
- [ ] BlocListener vs BlocBuilder vs BlocConsumer
- [ ] Hydrated Bloc 
- [ ] Bloc 
1.  BLoC 
2.  Bloc  > 80%
3.  Bloc 

---
```
lib/
├── features/
│   └── trading/
│       ├── domain/           #  Dart，
│       │   ├── entities/     # Order, Trade, Position
│       │   ├── repositories/ # 
│       │   └── usecases/     # PlaceOrderUseCase
│       ├── data/             # 
│       │   ├── models/       # OrderModel (Freezed + JSON)
│       │   ├── repositories/ # TradingRepositoryImpl
│       │   └── sources/      # RemoteDataSource, LocalDataSource
│       └── presentation/     # UI 
│           ├── pages/
│           ├── widgets/
│           └── cubits/
```

****:
- [ ] 
- [ ] Repository 
- [ ] UseCase 
- [ ] Mapper 
- [ ] （Either/Result）
- [Reso Coder Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)
-  AIGun 

---

```dart
@module
abstract class TradingModule {
  @lazySingleton
  TradingRemoteSource remoteSource(DioClient client) =>
    TradingRemoteSourceImpl(client);

  @lazySingleton
  TradingRepository repository(TradingRemoteSource source) =>
    TradingRepositoryImpl(source);

  @injectable
  TradingCubit cubit(TradingRepository repo) => TradingCubit(repo);
}
```

****:
- [ ] GetIt 
- [ ] Injectable 
- [ ] （dev/prod/test）
- [ ]  DI 

---
```dart
const Text('Fixed Text');
class OptimizedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 72, // 
      itemBuilder: (_, index) => const ListItem(),
    );
  }
}
RepaintBoundary(
  child: ComplexAnimatedWidget(),
)
```

****:
- [ ] DevTools Performance 
- [ ]  Jank（）
- [ ] Widget 
- [ ] （itemExtent、cacheExtent）
- [ ] （、、）
- [ ] Shader 
- [ ] （DevTools Memory）
- [ ] 
- [ ] Stream/Timer 
- [ ] Isolate 
- [ ] 
- [ ] 
- [ ] 

---
```yaml
# .github/workflows/flutter.yml
name: Flutter CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2

      - name: Install dependencies
        run: flutter pub get

      - name: Analyze
        run: flutter analyze

      - name: Test
        run: flutter test --coverage

      - name: Build APK
        run: flutter build apk --release
```

****:
- [ ] GitHub Actions 
- [ ] Fastlane 
- [ ] 
- [ ] （dart analyze、custom lint rules）
```dart
test('should place order successfully', () async {
  when(mockRepo.placeOrder(any)).thenAnswer((_) async => order);

  final result = await usecase(OrderParams(order));

  expect(result, Right(order));
  verify(mockRepo.placeOrder(order)).called(1);
});
testWidgets('should show order form', (tester) async {
  await tester.pumpWidget(MaterialApp(home: OrderPage()));

  expect(find.byType(TextField), findsNWidgets(3));
  expect(find.text('Place Order'), findsOneWidget);
});
testWidgets('complete trading flow', (tester) async {
});
```

---
```dart
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
String mnemonic = bip39.generateMnemonic();
Uint8List seed = bip39.mnemonicToSeed(mnemonic);
final root = bip32.BIP32.fromSeed(seed);
final child = root.derivePath("m/44'/60'/0'/0/0");
```

****:
- [ ] BIP-39 
- [ ] BIP-32 
- [ ] BIP-44 
- [ ] （flutter_secure_storage）
- [ ] 

---
```dart
import 'package:web3dart/web3dart.dart';

class EthereumService {
  final Web3Client _client;
  Future<EtherAmount> getBalance(EthereumAddress address) {
    return _client.getBalance(address);
  }
  Future<String> sendTransaction({
    required Credentials credentials,
    required EthereumAddress to,
    required EtherAmount value,
  }) async {
    return _client.sendTransaction(
      credentials,
      Transaction(
        to: to,
        value: value,
        maxGas: 21000,
      ),
      chainId: 1, // Mainnet
    );
  }
  Future<List<dynamic>> callContract(
    DeployedContract contract,
    ContractFunction function,
    List<dynamic> params,
  ) {
    return _client.call(
      contract: contract,
      function: function,
      params: params,
    );
  }
}
```

****:
- [ ] web3dart 
- [ ] 
- [ ] Gas 
- [ ]  ABI 
- [ ] 
```dart
import 'package:solana/solana.dart';

class SolanaService {
  final SolanaClient _client;
  Future<int> getBalance(Ed25519HDPublicKey address) {
    return _client.rpcClient.getBalance(address.toBase58());
  }
  Future<String> transfer({
    required Wallet wallet,
    required Ed25519HDPublicKey destination,
    required int lamports,
  }) async {
    final instruction = SystemInstruction.transfer(
      fundingAccount: wallet.publicKey,
      recipientAccount: destination,
      lamports: lamports,
    );

    final message = Message.only(instruction);
    return _client.sendAndConfirmTransaction(
      message: message,
      signers: [wallet],
    );
  }
}
```

****:
- [ ] Solana 
- [ ] SPL Token 
- [ ] 
- [ ] 

---

```dart
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WalletConnectService {
  late Web3Wallet _wallet;

  Future<void> init() async {
    _wallet = await Web3Wallet.createInstance(
      projectId: 'YOUR_PROJECT_ID',
      metadata: PairingMetadata(
        name: 'AIGun Wallet',
        description: 'Web3 Trading Wallet',
        url: 'https://aigun.io',
        icons: ['https://aigun.io/icon.png'],
      ),
    );
    _wallet.onSessionProposal.subscribe(_onSessionProposal);
    _wallet.onSessionRequest.subscribe(_onSessionRequest);
  }

  void _onSessionProposal(SessionProposalEvent? event) {
  }

  void _onSessionRequest(SessionRequestEvent? event) {
  }
}
```

****:
- [ ] WalletConnect v2 
- [ ] Session 
- [ ] 
- [ ] 

---

```dart
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DAppBrowser extends StatefulWidget {
  @override
  _DAppBrowserState createState() => _DAppBrowserState();
}

class _DAppBrowserState extends State<DAppBrowser> {
  InAppWebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri('https://app.uniswap.org')),
      onWebViewCreated: (controller) {
        _controller = controller;
        _injectProvider();
      },
      onConsoleMessage: (_, message) {
      },
    );
  }

  void _injectProvider() {
    _controller?.evaluateJavascript(source: '''
      window.ethereum = {
        isMetaMask: true,
        request: async (args) => {
          return window.flutter_inappwebview.callHandler('ethereum_request', args);
        },
        on: (event, callback) => { /* ... */ },
      };
    ''');
    _controller?.addJavaScriptHandler(
      handlerName: 'ethereum_request',
      callback: _handleEthereumRequest,
    );
  }

  dynamic _handleEthereumRequest(List<dynamic> args) async {
    final method = args[0]['method'];
    switch (method) {
      case 'eth_requestAccounts':
        return [walletAddress];
      case 'eth_chainId':
        return '0x1';
      case 'eth_sendTransaction':
        break;
    }
  }
}
```

****:
- [ ] EIP-1193 Provider 
- [ ] JavaScript Bridge 
- [ ] 
- [ ] 

---

**，**:
- [ ] WebSocket 
- [ ] K
- [ ] 
- [ ] （MA、MACD、RSI）
- [ ] 
- [ ] /
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 

---

****:
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 

- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 

-  Flutter 
-  Web3 
- 
- 

---

|         |     |                    |
| ------- | --- | ------------------ |
| Phase 1 | 1-2 | K                  |
| Phase 2 | 1-2 | Clean Architecture |
| Phase 3 | 1-2 | CI/CD ， > 70%     |
| Phase 4 | 2-3 |                    |
| Phase 5 |     |                    |

---
- 《Flutter 》- 
- 《 Flutter》- 
- [ Flutter ](https://coding.imooc.com/class/487.html)
- [B Flutter ](https://bilibili.com)
- [Flutter ](https://medium.com/flutter)
- [GSY Flutter ](https://guoshuyu.cn)
- [WalletConnect ](https://docs.walletconnect.com)
- [](https://ethereum.org/developers)
- [Solana Cookbook](https://solanacookbook.com)
- [Flutter ](https://flutter.cn)
- [](https://learnblockchain.cn)

---

```markdown
- [ ]  1
- [ ]  2
-
-
-
-
```

---
- [ ] 
- [ ]  BLoC + Clean Architecture
- [ ] 
- [ ] 
- [ ]  Web3 
- [ ] 
- [ ] 
- [ ] 
- [ ]  Web3 Flutter 

---

*，。*
