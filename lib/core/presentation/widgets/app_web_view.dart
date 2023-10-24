import 'dart:async';

import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class AppWebViewRouteArgument {
  AppWebViewRouteArgument({
    required this.title,
    required this.url,
    this.appBar,
    this.loadingBuilder,
    this.navigationDelegate,
  });

  final String url;
  final String title;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context)? loadingBuilder;
  final FutureOr<NavigationDecision> Function(NavigationRequest)? navigationDelegate;
}

class AppWebView extends StatefulWidget {
  const AppWebView({super.key});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  final ValueNotifier<bool> loadingValueNotifier = ValueNotifier<bool>(true);
  final Completer<WebViewXController<dynamic>> _controller = Completer<WebViewXController<dynamic>>();

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    loadingValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppWebViewRouteArgument args = ModalRoute.of(context)!.settings.arguments! as AppWebViewRouteArgument;
    String url = args.url;
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return TapOutsideUnfocus(
      child: Builder(
        builder: (_) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: args.appBar ??
                AppBar(
                  title: const Text(
                    'Web Browser',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: context.colors.text,
                      size: 25,
                    ),
                  ),
                ),
            body: WebViewAware(
              child: Stack(
                children: <Widget>[
                  WebViewX(
                    initialContent: url,
                    initialSourceType: SourceType.urlBypass,
                    onWebViewCreated: _controller.complete,
                    onPageStarted: (_) => loadingValueNotifier.value = true,
                    height: screenSize.height,
                    width: screenSize.width,
                    navigationDelegate: args.navigationDelegate ??
                        (NavigationRequest navigation) async {
                          if (navigation.content.source == url) {
                            return NavigationDecision.navigate;
                          }
                          return NavigationDecision.prevent;
                        },
                    onPageFinished: (_) async {
                      loadingValueNotifier.value = false;
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: loadingValueNotifier,
                    builder: (BuildContext context, bool loading, _) {
                      if (loading) {
                        return Positioned.fill(
                          child: args.loadingBuilder != null
                              ? args.loadingBuilder!(context)
                              : const Center(child: LoadingLogo()),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
