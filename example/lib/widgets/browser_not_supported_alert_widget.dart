import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_linkify/flutter_linkify.dart";
import "package:flutter_web_bluetooth_example/web_helpers/web_helpers.dart";
import "package:url_launcher/url_launcher.dart";
import "package:web_browser_detect/web_browser_detect.dart";

class BrowserNotSupportedAlertWidget extends StatelessWidget {
  const BrowserNotSupportedAlertWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    final browser = Browser.detectOrNull();
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge;
    final boldStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final linkStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.secondary,
      decoration: TextDecoration.underline,
    );

    return AlertDialog(
      title: const SelectableText("Browser not supported"),
      content: RichText(
        text: TextSpan(
          style: textStyle,
          children: [
            TextSpan(
              text:
                  "Your browser (${browser?.browser ?? "NOT DETECTED"}) does "
                  "not support Bluetooth yet.\n",
            ),
            if (kIsWeb && !WebHelpers.isSecureContext) ...[
              TextSpan(
                text: "The website isn't loaded via a secure context!\n",
                style: boldStyle,
              ),
              const TextSpan(text: "This may be the cause of your problem!\n"),
            ],
            if (browser?.browserAgent == BrowserAgent.Chrome) ...[
              const TextSpan(
                text:
                    "You may need to enable a browser flag for this to work "
                    "in a Chrome (based) browser. Go to ",
              ),
              WidgetSpan(
                child: SelectableText(
                  "about:flags#enable-experimental-web-platform-features",
                  style: boldStyle,
                ),
              ),
              const TextSpan(text: ". Enable the "),
              WidgetSpan(
                child: SelectableText(
                  "Experimental Web Platform features",
                  style: boldStyle,
                ),
              ),
              const TextSpan(
                text:
                    " flag. After a restart it should be able to "
                    "handle Bluetooth.\n",
              ),
            ],
            WidgetSpan(
              child: Linkify(
                text:
                    "Check out https://CanIUse.com for updates for your specific browser.",
                // style: textStyle,
                linkStyle: linkStyle,
                onOpen: (final link) async {
                  await launchUrl(
                    Uri.parse("https://caniuse.com/web-bluetooth"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        SimpleDialogOption(
          child: const Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static Future<void> showCustomDialog(final BuildContext context) {
    return showDialog(
      context: context,
      builder: (final BuildContext context) {
        return const BrowserNotSupportedAlertWidget();
      },
    );
  }
}
