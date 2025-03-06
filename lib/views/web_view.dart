// ignore_for_file: deprecated_member_use, unused_local_variable, depend_on_referenced_packages

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
as webview_flutter_android;
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewContainer extends StatefulWidget {
  final String url;
  const WebViewContainer(this.url, {super.key});
  @override
  createState() => _WebViewContainerState();
}
class _WebViewContainerState extends State<WebViewContainer> {

  late final WebViewController _controller;


  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest:  (NavigationRequest request) {
      if (request.url.startsWith("https://alrayyanprivateschools.com/supervisor")) {
      return NavigationDecision.navigate;
      } else {
      _launchURL(request.url);
      return NavigationDecision.prevent;
      }
      },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is webview_flutter_android.AndroidWebViewController) {
      webview_flutter_android.AndroidWebViewController.enableDebugging(true);
      (controller.platform as webview_flutter_android.AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
   initFilePicker();
  }
  _launchURL(String url) async {
    final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri);

  }
  /// handle attachments
  initFilePicker() async {
    if (Platform.isAndroid) {
      final androidController = (_controller.platform
      as webview_flutter_android.AndroidWebViewController);
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  /// This method is called when the user tries to upload a file from the webview.
  /// It will open the file picker and return the selected files.
  /// If the user cancels the file picker, it will return an empty list.
  ///
  /// Returns uri's of the selected files.
  Future<List<String>> _androidFilePicker(
      webview_flutter_android.FileSelectorParams params) async {
    if (params.acceptTypes.any((type) => type == 'image/*')) {
      final picker = image_picker.ImagePicker();
      final photo =
      await picker.pickImage(source: image_picker.ImageSource.camera);

      if (photo == null) {
        return [];
      }
      return [Uri.file(photo.path).toString()];
    } else if (params.acceptTypes.any((type) => type == 'video/*')) {
      final picker = image_picker.ImagePicker();
      final vidFile = await picker.pickVideo(
          source: image_picker.ImageSource.camera, maxDuration: const Duration(seconds: 10));
      if (vidFile == null) {
        return [];
      }
      return [Uri.file(vidFile.path).toString()];
    } else {
      try {
        if (params.mode ==
            webview_flutter_android.FileSelectorMode.openMultiple) {
          final attachments =
          await FilePicker.platform.pickFiles(allowMultiple: true);
          if (attachments == null) return [];

          return attachments.files
              .where((element) => element.path != null)
              .map((e) => File(e.path!).uri.toString())
              .toList();
        } else {
          final attachment = await FilePicker.platform.pickFiles();
          if (attachment == null) return [];
          File file = File(attachment.files.single.path!);
          return [file.uri.toString()];
        }
      } catch (e) {
        return [];
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    return Scaffold(
      
      body:   WillPopScope(
        onWillPop: () async {
      if (await _controller.canGoBack()) {
        _controller.goBack();
         return false;
          } else {
          debugPrint('No history available');
          return true;
          }
           },
        child: SafeArea(
          child: WebViewWidget(
             controller: _controller,
          ),
        ),
      ),
    );
  }
}