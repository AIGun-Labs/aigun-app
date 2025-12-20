import 'package:flutter_test/flutter_test.dart';
import 'package:aigun/core/widgets/dialogs/models/dialog_config.dart';
import 'package:aigun/core/widgets/dialogs/models/dialog_action.dart';
import 'package:aigun/core/widgets/dialogs/models/dialog_type.dart';

void main() {
  group('DialogConfig', () {
    test('should create info dialog config', () {
      final config = DialogConfig.info(
        title: 'Test',
        message: 'Message',
      );

      expect(config.type, DialogType.info);
      expect(config.title, 'Test');
      expect(config.message, 'Message');
      expect(config.actions?.length, 1);
    });

    test('should create warning dialog config', () {
      final config = DialogConfig.warning(
        title: 'Warning',
        message: 'Be careful',
      );

      expect(config.type, DialogType.warning);
      expect(config.title, 'Warning');
      expect(config.message, 'Be careful');
    });

    test('should create confirm dialog with two actions', () {
      var confirmCalled = false;
      var cancelCalled = false;

      final config = DialogConfig.confirm(
        title: 'Confirm',
        message: 'Are you sure?',
        onConfirm: () => confirmCalled = true,
        onCancel: () => cancelCalled = true,
      );

      expect(config.type, DialogType.confirm);
      expect(config.actions?.length, 2);

      // Test callbacks
      config.actions![0].onPressed?.call();
      expect(cancelCalled, true);

      config.actions![1].onPressed?.call();
      expect(confirmCalled, true);
    });

    test('should create error dialog config', () {
      final config = DialogConfig.error(
        title: 'Error',
        message: 'Something went wrong',
      );

      expect(config.type, DialogType.error);
      expect(config.title, 'Error');
    });

    test('should create success dialog config', () {
      final config = DialogConfig.success(
        title: 'Success',
        message: 'Operation completed',
      );

      expect(config.type, DialogType.success);
    });

    test('should support copyWith', () {
      final config = DialogConfig.info(
        title: 'Original',
        message: 'Original message',
      );

      final updated = config.copyWith(
        title: 'Updated',
      );

      expect(updated.title, 'Updated');
      expect(updated.message, 'Original message');
    });
  });

  group('DialogAction', () {
    test('should create primary action', () {
      final action = DialogAction.primary(
        label: 'OK',
        onPressed: () {},
      );

      expect(action.type, DialogActionType.primary);
      expect(action.label, 'OK');
      expect(action.dismissOnTap, true);
    });

    test('should create secondary action', () {
      final action = DialogAction.secondary(
        label: 'Cancel',
        onPressed: null,
      );

      expect(action.type, DialogActionType.secondary);
      expect(action.label, 'Cancel');
    });

    test('should create destructive action', () {
      final action = DialogAction.destructive(
        label: 'Delete',
        onPressed: () {},
      );

      expect(action.type, DialogActionType.primary);
      expect(action.isDestructive, true);
      expect(action.label, 'Delete');
    });

    test('should create cancel action with default label', () {
      final action = DialogAction.cancel();

      expect(action.label, '取消');
      expect(action.type, DialogActionType.secondary);
    });

    test('should create confirm action', () {
      final action = DialogAction.confirm(
        onPressed: () {},
      );

      expect(action.label, '确认');
      expect(action.type, DialogActionType.primary);
    });
  });
}
