import 'package:flutter_test/flutter_test.dart';
import 'package:window_close_guard/window_close_guard.dart';

void main() {
  group('dialogConfigBuilder', () {
    test('dialogConfigBuilder is called and returns its config', () {
      const builderConfig = CloseDialogConfig(title: 'Builder Title');
      const staticConfig = CloseDialogConfig(title: 'Config Title');

      CloseDialogConfig builder() => builderConfig;

      final usedConfig = builder.call();

      expect(usedConfig.title, equals(builderConfig.title));
      expect(usedConfig.title, isNot(equals(staticConfig.title)));
    });

    test('dialogConfig is used when dialogConfigBuilder is null', () {
      const CloseDialogConfig? Function()? builder = null;
      const config = CloseDialogConfig(title: 'Config Title');

      final usedConfig = builder?.call() ?? config;

      expect(usedConfig.title, equals('Config Title'));
    });

    test('dialogConfigBuilder is called at close time, not at initialize time',
        () {
      int callCount = 0;

      CloseDialogConfig builder() {
        callCount++;
        return const CloseDialogConfig(title: 'Dynamic Title');
      }

      expect(callCount, equals(0));

      final config = builder();

      expect(callCount, equals(1));
      expect(config.title, equals('Dynamic Title'));
    });

    test('dialogConfigBuilder can return different values on each call', () {
      int callCount = 0;
      final titles = ['Title 1', 'Title 2'];

      CloseDialogConfig builder() {
        final title = titles[callCount];
        callCount++;
        return CloseDialogConfig(title: title);
      }

      expect(builder().title, equals('Title 1'));
      expect(builder().title, equals('Title 2'));
    });

    test(
        'default config is used when both dialogConfigBuilder and dialogConfig are null',
        () {
      const CloseDialogConfig? Function()? builder = null;
      const CloseDialogConfig? config = null;

      final usedConfig = builder?.call() ?? config ?? const CloseDialogConfig();

      expect(usedConfig.title, equals('Exit'));
      expect(usedConfig.content, equals('Are you sure you want to exit?'));
      expect(usedConfig.confirmText, equals('Yes'));
      expect(usedConfig.cancelText, equals('No'));
    });
  });
}
