import 'package:betticos/core/core.dart';

abstract class OnBoardLocalDataSource {
  Future<bool?> getOnBoard();
  Future<void> clearOnBoard();
  Future<void> saveOnBoard(bool onboard);
}

class OnBoardLocalDataSourceImpl extends OnBoardLocalDataSource {
  OnBoardLocalDataSourceImpl(this._preferencesWrapper);

  final SharedPreferencesWrapper _preferencesWrapper;

  @override
  Future<void> clearOnBoard() async {
    await _preferencesWrapper.remove(SharedPrefsKeys.onBoard);
  }

  @override
  Future<bool?> getOnBoard() async {
    final bool? onboard =
        await _preferencesWrapper.getBool(SharedPrefsKeys.onBoard);
    if (onboard != null) {
      return onboard;
    }
    return null;
  }

  @override
  Future<void> saveOnBoard(bool onboard) async {
    await _preferencesWrapper.setBool(SharedPrefsKeys.onBoard, onboard);
  }
}
