
════════ Exception caught by rendering library ═════════════════════════════════
The following assertion was thrown during performLayout():
Cannot get renderObject of inactive element.
In order for an element to have a valid renderObject, it must be active, which means it is part of the tree.
Instead, this element is in the _ElementLifecycle.inactive state.
If you called this method from a State object, consider guarding it with State.mounted.
The findRenderObject() method was called for the following element: StretchingOverscrollIndicator
    axisDirection: down
    state: _StretchingOverscrollIndicatorState#c1906(tickers: tracking 1 ticker)

The relevant error-causing widget was:
    SmartRefresher SmartRefresher:file:///Users/lian/Development/flutter-ai-gun/lib/screens/intel/widgets/intel_list.dart:63:16
