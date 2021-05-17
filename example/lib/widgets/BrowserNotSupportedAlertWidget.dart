import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_web_bluetooth_example/webHelpers/WebHelpers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_browser_detect/web_browser_detect.dart';

class BrowserNotSupportedAlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final browser = Browser.detectOrNull();
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1;
    final boldStyle =
        theme.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold);
    final linkStyle = theme.textTheme.bodyText1?.copyWith(
        color: theme.accentColor, decoration: TextDecoration.underline);

    return AlertDialog(
      title: SelectableText('Browser not supported'),
      content: RichText(
          text: TextSpan(style: textStyle, children: [
        TextSpan(
            text: 'Your browser (${browser?.browser ?? 'NOT DETECTED'}) does '
                'not support Bluetooth yet.\n'),
        if (kIsWeb && !WebHelpers.isSecureContext) ...[
          TextSpan(
              text: 'The website isn\'t loaded via a secure context!\n',
              style: boldStyle),
          TextSpan(text: 'This may be the cause of your problem!\n')
        ],
        if (browser?.browserAgent == BrowserAgent.Chrome) ...[
          TextSpan(
              text: 'You may need to enable a browser flag for this to work '
                  'in a Chrome (based) browser. Go to '),
          WidgetSpan(
              child: SelectableText(
            'about:flags#enable-experimental-web-platform-features',
            style: boldStyle,
          )),
          TextSpan(text: '. Enable the '),
          WidgetSpan(
              child: SelectableText(
            'Experimental Web Platform features',
            style: boldStyle,
          )),
          TextSpan(
              text: ' flag. After a restart it should be able to '
                  'handle Bluetooth.\n')
        ],
        WidgetSpan(
            child: Linkify(
          text:
              'Check out https://CanIUse.com for updates for your specific browser.',
          // style: textStyle,
          linkStyle: linkStyle,
          onOpen: (link) {
            launch('https://caniuse.com/web-bluetooth');
          },
        )),
      ])),
      actions: [
        SimpleDialogOption(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  static Future<void> showCustomDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return BrowserNotSupportedAlertWidget();
        });
  }
}
