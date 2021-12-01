import 'package:flutter/material.dart';
import '../../Shared/Theme/Colors.dart';
import '../../Shared/Extensions/ScreenUtilExtension.dart';

class KaytaLoadingOverlay extends StatefulWidget {
  final bool loading;
  final bool? canPop;
  final Widget? progressIndicator;
  final Widget child;
  final double opacity;
  final Color color;

  KaytaLoadingOverlay({
    this.loading = false,
    this.canPop,
    required this.child,
    this.opacity = 0.5,
    this.progressIndicator,
    this.color = Colors.black,
  });

  @override
  _KaytaLoadingOverlayState createState() => _KaytaLoadingOverlayState();
}

class _KaytaLoadingOverlayState extends State<KaytaLoadingOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool? _overlayVisible;

  _KaytaLoadingOverlayState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      // ignore: unnecessary_statements
      status == AnimationStatus.forward ? setState(() => {_overlayVisible = true}) : null;
      // ignore: unnecessary_statements
      status == AnimationStatus.dismissed ? setState(() => {_overlayVisible = false}) : null;
    });
    if (widget.loading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(KaytaLoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.loading && widget.loading) {
      _controller.forward();
    }

    if (oldWidget.loading && !widget.loading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color,
              ),
              opacity: widget.opacity,
            ),
            Center(
              child: widget.progressIndicator ??
                  Container(
                    height: 80.height,
                    width: 80.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.radius),
                    ),
                    child: Center(
                      child: Container(
                        height: 40.height,
                        width: 40.width,
                        child: CircularProgressIndicator(color: VvsColors.primary, strokeWidth: 4.width),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      );
      widgets.add(modal);
    }

    return WillPopScope(
      onWillPop: () async => widget.canPop ?? widget.loading == false,
      child: Stack(children: widgets),
    );
  }
}
