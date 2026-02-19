import 'package:flutter/material.dart'
    show MaterialApp, Scaffold, Text, ElevatedButton, Widget, Builder;
import 'package:flutter_test/flutter_test.dart'
    show group, expect, testWidgets, find, findsOneWidget;
import 'package:window_close_guard/src/widgets/confirm_dialog.dart'
    show ConfirmDialog;
import 'package:window_close_guard/window_close_guard.dart'
    show CloseDialogConfig;

void main() {
  const config = CloseDialogConfig(
    title: 'Exit',
    content: 'Are you sure you want to exit?',
    confirmText: 'Yes',
    cancelText: 'No',
  );

  Widget buildDialog({Future<void> Function()? onClose}) {
    return MaterialApp(
      home: Scaffold(
        body: ConfirmDialog(config: config, onClose: onClose),
      ),
    );
  }

  group('ConfirmDialog', () {
    testWidgets('renders title correctly', (tester) async {
      await tester.pumpWidget(buildDialog());

      expect(find.text('Exit'), findsOneWidget);
    });

    testWidgets('renders content correctly', (tester) async {
      await tester.pumpWidget(buildDialog());

      expect(find.text('Are you sure you want to exit?'), findsOneWidget);
    });

    testWidgets('renders confirm button correctly', (tester) async {
      await tester.pumpWidget(buildDialog());

      expect(find.text('Yes'), findsOneWidget);
    });

    testWidgets('renders cancel button correctly', (tester) async {
      await tester.pumpWidget(buildDialog());

      expect(find.text('No'), findsOneWidget);
    });

    testWidgets('returns false when cancel is tapped', (tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    result = await ConfirmDialog.show(
                      context,
                      config: config,
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      expect(result, false);
    });

    testWidgets('returns true when confirm is tapped', (tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    result = await ConfirmDialog.show(
                      context,
                      config: config,
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(result, true);
    });

    testWidgets('executes onClose when confirm is tapped', (tester) async {
      bool onCloseCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await ConfirmDialog.show(
                      context,
                      config: config,
                      onClose: () async {
                        onCloseCalled = true;
                      },
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      expect(onCloseCalled, true);
    });

    testWidgets('does not execute onClose when cancel is tapped',
        (tester) async {
      bool onCloseCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await ConfirmDialog.show(
                      context,
                      config: config,
                      onClose: () async {
                        onCloseCalled = true;
                      },
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      expect(onCloseCalled, false);
    });
  });
}
