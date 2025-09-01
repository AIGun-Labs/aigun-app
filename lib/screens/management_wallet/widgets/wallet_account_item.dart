import 'package:flutter/material.dart';
import '../../../data/models/wallet_group/wallet_group.dart';

class WalletAccountItem extends StatelessWidget {
  final WalletAccount account;
  final bool isSelected;
  final VoidCallback onTap;

  const WalletAccountItem({
    super.key,
    required this.account,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: ListTile(
        tileColor: Colors.transparent,
        selectedTileColor: Colors.transparent,
        selected: isSelected,
        selectedColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: .1),
          child: Text(
            account.name[0].toUpperCase(),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        title: Text(
          account.name,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        subtitle: Text(
          account.balance,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor)
            : null,
      ),
    );
  }
}
