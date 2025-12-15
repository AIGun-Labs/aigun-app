import '../candlestick_widget.dart';


class BaseDimension {

  double _mBaseHeight = 380;


  double _mVolumeHeight = 0;


  double _mSecondaryHeight = 0;
  double _totalSecondaryHeight = 0;

  double _mLabelHeight = 12;
  double _totalLabelHeight = 12;




  double _mDisplayHeight = 0;


  double get mVolumeHeight => _mVolumeHeight;


  double get mSecondaryHeight => _mSecondaryHeight;
  double get totalSecondaryHeight => _totalSecondaryHeight;

  double get mLabelHeight => _mLabelHeight;
  double get totalLabelHeight => _totalLabelHeight;


  double get mDisplayHeight => _mDisplayHeight;






  BaseDimension({
    required double mBaseHeight,
    required bool volHidden,
    required Set<SecondaryState> secondaryStateLi,
    required Set<MainState> mainStateLi,
  }) {
    _mBaseHeight = mBaseHeight;
    _mVolumeHeight = volHidden != true ? _mBaseHeight * 0.2 : 0;
    _mSecondaryHeight = _mBaseHeight * 0.2;
    _totalSecondaryHeight = _mSecondaryHeight * secondaryStateLi.length;
    _totalLabelHeight = _mLabelHeight * mainStateLi.length;

    _mDisplayHeight = _mBaseHeight +
        _mVolumeHeight +
        _totalSecondaryHeight +
        _totalLabelHeight;
  }
}
