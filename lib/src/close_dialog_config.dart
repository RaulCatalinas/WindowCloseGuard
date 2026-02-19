class CloseDialogConfig {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;

  const CloseDialogConfig({
    this.title = 'Exit',
    this.content = 'Are you sure you want to exit?',
    this.confirmText = 'Yes',
    this.cancelText = 'No',
  });
}
