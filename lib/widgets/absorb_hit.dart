import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RenderAbsorbHit extends RenderProxyBox {
  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
}

class AbsorbHit extends SingleChildRenderObjectWidget {
  const AbsorbHit({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAbsorbHit();
  }
}
