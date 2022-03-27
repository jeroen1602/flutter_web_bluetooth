# Chrome experimental

To test this library on some platforms you will need to launch chrome with the
[`Experimental Web Platform features`](chrome://flags/#enable-experimental-web-platform-features) flag enabled.

This folder contains a patch file so that `flutter run -d chrome` will launch a chrome instance with this flag enabled.
To enable this feature, first run the patch.

Copy the `Add-experimental-launch-flag.patch` file into the flutter folder. The file tree of the flutter folder should
look something like this:

```text
flutter/
 |-bin/
 |-dev/
 |-examples/
 |-packages/
 |-.git/
 |-.github/
 |-AUTHORS
 |-CODEOWNERS
 |-CODE_OF_CONDUCT.md
 |-...
```

Now that hte file is in the flutter folder we need to apply the patch.

```bash
patch -p1 < Add-experimental-launch-flag.patch
```

After patching, you can verify with running `git diff`. The contents of git diff should look the same as the content of
the `Add-experimental-launch-flag.patch` file.

Now we have to clear the snapshot cache so that flutter will rebuild the next time you run it and the changes will take
effect.

to do this delete the `bin/cache/flutter_tools.snapshot` file.

## Versions:

This patch was originally written for Flutter 2.0.4.

Also works with:
 - 2.0.5
 - 2.2.0
 - 2.8.1

# Running as a webserver

Another option is using `flutter run -d web-server --web-port 8080`. And then opening your normal Chrome browser where
you have already enabled the experimental flag.
