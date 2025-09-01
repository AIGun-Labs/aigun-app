import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkInfo extends StatelessWidget {
  final String name;
  final String chainId;
  final List<String> addresses;
  const NetworkInfo({
    super.key,
    required this.name,
    required this.chainId,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16.0.sp,
              height: 1.2.h,
            ),
          ),
          // GestureDetector(
          //   onTap: addresses.length > 1
          //       ? () {
          //           showModalBottomSheet(
          //             context: context,
          //             builder: (context) {
          //               return ListView.builder(
          //                 itemCount: addresses.length,
          //                 itemBuilder: (context, index) {
          //                   final addr = addresses[index];
          //                   return ListTile(
          //                     title: Text(addr),
          //                     onTap: () {
          //                       Navigator.pop(context);
          //                     },
          //                   );
          //                 },
          //               );
          //             },
          //           );
          //         }
          //       : null,
          //   child: Text(
          //     addresses.isNotEmpty
          //         ? AddressFormatter.formatAddress(addresses.first)
          //         : S.of(context).wallet_noAddress,
          //     style: TextStyle(
          //       fontSize: 14.sp,
          //       // color: addresses.length > 1
          //       //     ? Theme.of(context).primaryColor
          //       //     : Color(0xB3101010),
          //       color: Colors.white,
          //       height: 1.2.h,
          //       decoration: addresses.length > 1
          //           ? TextDecoration.underline
          //           : TextDecoration.none,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
