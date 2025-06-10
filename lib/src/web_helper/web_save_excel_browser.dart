import 'dart:typed_data';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

// A wrapper to save the excel file in browser
class SavingHelper {
  static List<int>? saveFile(List<int>? val, String fileName) {
    if (val == null) return null;

    final data = Uint8List.fromList(val).buffer.toJS;
    final blob = web.Blob([data].toJS);

    // Create an object URL for the Blob
    final url = web.URL.createObjectURL(blob);

    // Create an anchor element
    final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
    anchor.href = url;
    anchor.style.display = 'none';
    anchor.download = fileName;

    // Append the anchor to the body
    web.document.body?.appendChild(anchor);

    // Trigger a click on the anchor to start the download
    anchor.click();

    // Clean up: remove the anchor and revoke the object URL
    web.document.body?.removeChild(anchor);
    web.URL.revokeObjectURL(url);

    return val;
  }
}
