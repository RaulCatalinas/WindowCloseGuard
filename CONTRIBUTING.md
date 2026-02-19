# Contributing to WindowCloseGuard

Thank you for your interest in contributing to WindowCloseGuard! All contributions are welcome, whether it's a bug fix, a new feature, an improvement to the documentation, or just reporting a bug.

## Table of contents

- [Code of Conduct](#code-of-conduct)
- [Getting started](#getting-started)
- [Reporting bugs & suggesting features](#reporting-bugs--suggesting-features)
- [How to contribute](#how-to-contribute)
- [Code style](#code-style)
- [Commit conventions](#commit-conventions)
- [Pull request guidelines](#pull-request-guidelines)

## Code of Conduct

This project follows a simple rule: **treat everyone with respect**. Harassment, discrimination, or any kind of disrespectful behavior will not be tolerated. By contributing, you agree to maintain a welcoming and inclusive environment for everyone.

## Getting started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) >= 3.10.0
- [Dart](https://dart.dev/get-dart) >= 3.0.0
- A desktop OS: Windows, macOS or Linux

### Running the project locally

1. Fork the repository and clone it:

```bash
git clone https://github.com/your-username/WindowCloseGuard.git
cd WindowCloseGuard
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the example app to verify everything works:

```bash
cd example
flutter run -d windows # or macos, linux
```

4. Run the tests:

```bash
flutter test
```

## Reporting bugs & suggesting features

Not all contributions are code. Reporting a bug or suggesting a feature is just as valuable.

### Reporting a bug

Before opening an issue, please check if it has already been reported. If not, open a new issue and include:

- Your OS and version (e.g. Windows 11, macOS Ventura, Ubuntu 22.04)
- Your Flutter and Dart versions (`flutter --version`)
- The version of `window_close_guard` you are using
- A minimal code example that reproduces the issue
- The expected behavior vs what actually happens

### Suggesting a feature

Open an issue describing:

- What problem you are trying to solve
- What behavior you would expect
- Any alternative you have considered

## How to contribute

1. Fork the repository
2. Create a new branch from `main`:

```bash
git checkout -b feat/your-feature-name
```

3. Make your changes
4. Make sure the tests pass:

```bash
flutter test
```

5. Commit your changes following the [commit conventions](#commit-conventions)
6. Push your branch and open a Pull Request against `main`

## Code style

- Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Run `flutter analyze` before submitting — no warnings or errors are acceptable
- Run `dart format .` to format your code before committing
- Keep the public API as simple as possible — this package is designed to be used in a single line if needed

## Commit conventions

This project follows [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <short description>
```

### Types

| Type | When to use |
|------|-------------|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation changes only |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `test` | Adding or updating tests |
| `chore` | Maintenance tasks (dependencies, config, etc.) |

### Examples

```
feat: add support for custom dialog widget
fix: prevent app freeze on Windows when closing
docs: update API reference for CloseDialogConfig
refactor: simplify window close lifecycle handling
test: add tests for onClose callback execution order
chore: update window_manager to 2.4.0
```

## Pull request guidelines

- Keep PRs focused — one change per PR
- Update the README if your change affects the public API or behavior
- Add or update tests if applicable
- Make sure `flutter analyze` and `flutter test` pass before requesting a review
- Provide a clear description of what the PR does and why
