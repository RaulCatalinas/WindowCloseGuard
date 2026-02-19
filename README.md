# WindowCloseGuard

A Flutter package for safe window close handling on desktop with confirmation dialog support.

## Features

- ✅ Intercepts the window close event on **Windows**, **macOS** and **Linux**
- ✅ Shows a customizable confirmation dialog before closing
- ✅ Executes async cleanup tasks (saving data, logs, etc.) before the window is destroyed
- ✅ Handles the close lifecycle correctly on all platforms

## Platform support

| Platform | Supported |
|----------|-----------|
| Windows  | ✅ |
| macOS    | ✅ |
| Linux    | ✅ |
| Android  | ❌ |
| iOS      | ❌ |
| Web      | ❌ |

## Installation

Add `window_close_guard` to your `pubspec.yaml`:

```yaml
dependencies:
  window_close_guard: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

Call `WindowCloseGuard.initialize()` in your `main()` function, after `WidgetsFlutterBinding.ensureInitialized()` and before `runApp()`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WindowCloseGuard.initialize(
    onClose: () async {
      await MyPreferences.save();
      await MyLogger.saveLogs();
    },
    dialog: CloseDialogConfig(
      title: 'Exit',
      content: 'Are you sure you want to exit?',
      confirmText: 'Yes',
      cancelText: 'No',
    ),
  );

  runApp(const MyApp());
}
```

### Without a confirmation dialog

If you just want to run cleanup tasks without asking the user for confirmation:

```dart
await WindowCloseGuard.initialize(
  onClose: () async {
    await MyPreferences.save();
  },
);
```

## API Reference

### `WindowCloseGuard.initialize()`

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `onClose` | `Future<void> Function()?` | No | Async callback executed before the window closes |
| `dialog` | `CloseDialogConfig?` | No | Configuration for the confirmation dialog. If null, no dialog is shown |

### `CloseDialogConfig`

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `title` | `String` | Yes | Dialog title |
| `content` | `String` | Yes | Dialog body text |
| `confirmText` | `String` | No | Confirm button label. Defaults to `"Yes"` |
| `cancelText` | `String` | No | Cancel button label. Defaults to `"No"` |

## Important notes

### Why not `windowManager.destroy()`?

Internally, `WindowCloseGuard` uses `setPreventClose(false)` + `close()` instead of `destroy()` to close the window. This is intentional.

Calling `destroy()` directly bypasses the native close lifecycle of the operating system:

- On **Windows**, Win32 expects the close flow to go through `WM_CLOSE` → `WM_DESTROY` in order. Skipping this with `destroy()` leaves the Flutter process in an inconsistent state, causing the app to freeze and crash.
- On **macOS**, Cocoa is more tolerant and cleans up automatically, so `destroy()` appears to work — but it's still not the correct approach.
- On **Linux**, GTK has its own native close lifecycle similar to Win32, so the same issue is expected.

Using `setPreventClose(false)` + `close()` lets the OS handle the close flow natively and cleanly on all platforms.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request on [GitHub](https://github.com/RaulCatalinas/WindowCloseGuard).

Please make sure to:
- Follow the existing code style
- Add tests for new functionality
- Update the documentation if needed

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
