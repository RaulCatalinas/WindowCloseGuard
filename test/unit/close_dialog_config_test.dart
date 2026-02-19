import 'package:flutter_test/flutter_test.dart';
import 'package:window_close_guard/src/close_dialog_config.dart';

void main() {
  group('CloseDialogConfig', () {
    group('default values', () {
      late CloseDialogConfig config;

      setUp(() {
        config = const CloseDialogConfig();
      });

      test('title defaults to "Exit"', () {
        expect(config.title, 'Exit');
      });

      test('content defaults to "Are you sure you want to exit?"', () {
        expect(config.content, 'Are you sure you want to exit?');
      });

      test('confirmText defaults to "Yes"', () {
        expect(config.confirmText, 'Yes');
      });

      test('cancelText defaults to "No"', () {
        expect(config.cancelText, 'No');
      });
    });

    group('custom values', () {
      late CloseDialogConfig config;

      setUp(() {
        config = const CloseDialogConfig(
          title: 'Custom title',
          content: 'Custom content',
          confirmText: 'Custom confirm',
          cancelText: 'Custom cancel',
        );
      });

      test('title is set correctly', () {
        expect(config.title, 'Custom title');
      });

      test('content is set correctly', () {
        expect(config.content, 'Custom content');
      });

      test('confirmText is set correctly', () {
        expect(config.confirmText, 'Custom confirm');
      });

      test('cancelText is set correctly', () {
        expect(config.cancelText, 'Custom cancel');
      });
    });
  });
}
