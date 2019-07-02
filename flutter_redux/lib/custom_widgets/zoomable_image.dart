import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cached_network_image/cached_network_image.dart';

/// Author : perlatus
///
/// Source code taken from :
/// https://github.com/perlatus/flutter_zoomable_image/blob/master/lib/src/zoomable_image.dart
///
/// Modified for use in app
class ZoomableImage extends StatefulWidget {
  final String url;
  final double maxScale;
  final GestureTapCallback onTap;
  final Color backgroundColor;

  ZoomableImage(
    this.url, {
    Key key,
    this.maxScale = 2.0,
    this.onTap,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  @override
  _ZoomableImageState createState() => new _ZoomableImageState();
}

// See /flutter/examples/layers/widgets/gestures.dart
class _ZoomableImageState extends State<ZoomableImage> {
  ImageStream _imageStream;
  ui.Image _image;
  Size _imageSize;

  Offset _startingFocalPoint;

  Offset _previousOffset;
  Offset _offset; // where the top left corner of the image is drawn

  double _previousScale;
  double _scale; // multiplier applied to scale the full image

  Orientation _previousOrientation;

  Size _canvasSize;

  double _defaultScale = -1.0;
  MediaQueryData _mediaQuery;

  void _centerAndScaleImage() {
    _imageSize = new Size(
      _image.width.toDouble(),
      _image.height.toDouble(),
    );

    _scale = math.min(
      _canvasSize.width / _imageSize.width,
      _canvasSize.height / _imageSize.height,
    );
    Size fitted = new Size(
      _imageSize.width * _scale,
      _imageSize.height * _scale,
    );

    Offset delta = _canvasSize - fitted;
    _offset = delta / 2.0; // Centers the image

    _defaultScale = _scale;
  }

  Function() _handleDoubleTap(BuildContext ctx) {
    return () {
      double newScale = _scale * 2;
      if (newScale > widget.maxScale) {
        _centerAndScaleImage();
        setState(() {});
        return;
      }

      // We want to zoom in on the center of the screen.
      // Since we're zooming by a factor of 2, we want the new offset to be twice
      // as far from the center in both width and height than it is now.
      Offset center = ctx.size.center(Offset.zero);
      Offset newOffset = _offset - (center - _offset);

      setState(() {
        _scale = newScale;
        _offset = newOffset;
      });
    };
  }

  void _handleScaleStart(ScaleStartDetails d) {
    _startingFocalPoint = d.focalPoint;
    _previousOffset = _offset;
    _previousScale = _scale;
  }

  void _handleScaleUpdate(ScaleUpdateDetails d) {
    double newScale = _previousScale * d.scale;
    if (newScale > widget.maxScale) {
      return;
    }
    if (newScale < _defaultScale) {
      // Don't zoom out than original
      return;
    }

    // Ensure that item under the focal point stays in the same place despite zooming
    final Offset normalizedOffset =
        (_startingFocalPoint - _previousOffset) / _previousScale;
    final Offset newOffset = d.focalPoint - normalizedOffset * newScale;

    double padding = 100.0;
    double _boundMinX = _mediaQuery.size.width - _imageSize.width *_scale - padding;
    double _boundMinY = 0.0 - padding;
    double _boundMaxX = 0.0 + padding;
    double _boundMaxY = _mediaQuery.size.height -  _imageSize.height *_scale + padding;
    if (newOffset.dx < _boundMinX || newOffset.dy < _boundMinY) {
      double _new_dx = math.max(_boundMinX, newOffset.dx);
      double _new_dy = math.max(_boundMinY, newOffset.dy);
      setState(() {
        _offset = Offset(_new_dx, _new_dy);
      });
      return;
    }
    if (newOffset.dx > _boundMaxX || newOffset.dy > _boundMaxY) {
      double _new_dx = math.min(_boundMaxX, newOffset.dx);
      double _new_dy = math.min(_boundMaxY, newOffset.dy);
      setState(() {
        _offset = Offset(_new_dx, _new_dy);
      });
      return;
    }

    setState(() {
      _scale = newScale;
      _offset = newOffset;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    _mediaQuery = MediaQuery.of(context);
    Widget paintWidget() {
      return new CustomPaint(
        child: new Container(color: widget.backgroundColor),
        foregroundPainter: new _ZoomableImagePainter(
          image: _image,
          offset: _offset,
          scale: _scale,
        ),
      );
    }

    if (_image == null) {
      return CircularProgressIndicator();
    }

    return new LayoutBuilder(builder: (ctx, constraints) {
      Orientation orientation = MediaQuery.of(ctx).orientation;
      if (orientation != _previousOrientation) {
        _previousOrientation = orientation;
        _canvasSize = constraints.biggest;
        _centerAndScaleImage();
      }

      return new GestureDetector(
        child: paintWidget(),
        onTap: widget.onTap,
        onDoubleTap: _handleDoubleTap(ctx),
        onScaleStart: _handleScaleStart,
        onScaleUpdate: _handleScaleUpdate,
      );
    });
  }

  @override
  void didChangeDependencies() {
    _resolveImage();
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    _resolveImage(); // in case the image cache was flushed
    super.reassemble();
  }

  void _resolveImage() {
    _imageStream = CachedNetworkImageProvider(widget.url)
        .resolve(createLocalImageConfiguration(context));
    _imageStream.addListener(_handleImageLoaded);
  }

  void _handleImageLoaded(ImageInfo info, bool synchronousCall) {
    setState(() {
      _image = info.image;
    });
  }

  @override
  void dispose() {
    _imageStream.removeListener(_handleImageLoaded);
    super.dispose();
  }
}

class _ZoomableImagePainter extends CustomPainter {
  const _ZoomableImagePainter({this.image, this.offset, this.scale});

  final ui.Image image;
  final Offset offset;
  final double scale;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    Size imageSize = new Size(image.width.toDouble(), image.height.toDouble());
    Size targetSize = imageSize * scale;

    paintImage(
      canvas: canvas,
      rect: offset & targetSize,
      image: image,
      fit: BoxFit.fill,
    );
  }

  @override
  bool shouldRepaint(_ZoomableImagePainter old) {
    return old.image != image || old.offset != offset || old.scale != scale;
  }
}
