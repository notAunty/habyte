import 'package:habyte/models/entry.dart';
import 'package:habyte/viewmodels/general.dart';

/// **Entry ViewModel Class**
///
/// Involves:
/// - Entry Model
/// - CRUD
/// - Other operations
class Entries {
  static final Entries _entries = Entries._internal();
  Entries._internal();

  /// Get the `Entry` instance for user `CRUD` and other operations
  factory Entries.getInstance() => _entries;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.entry;
  List<EntryModel> _currentEntries = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentEntries(List<EntryModel> entryModelList) {
    _currentEntries = entryModelList;
  }

  /// **Create Entry** (`C` in CRUD)
  ///
  /// Create entry will need to pass a map with the pairs of key and value
  ///
  /// Below are the keys for creating `Entry`:
  /// - `ENTRY_TASK_ID`
  /// - `ENTRY_COMPLETED_DATE`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void createEntry(Map<String, dynamic> entryJson) {
    EntryModel _entryModel = EntryModel.fromJson(entryJson);
    _entryModel.id = _general.getBoxItemNewId(_boxType);
    _currentEntries.add(_entryModel);
    _general.addBoxItem(_boxType, _entryModel.id, _entryModel);
  }

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of EntryModel`.
  List<EntryModel> retrieveAllEntries() => _currentEntries;

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `EntryModel`).
  List<Map<String, dynamic>> retrieveAllEntriesInListOfMap() => _toListOfMap();

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `EntryModel`.
  ///
  /// Parameter required: `id` from `EntryModel`.
  EntryModel retrieveEntryById(String id) =>
      _currentEntries.singleWhere((entryModel) => entryModel.id == id);

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of EntryModel` from `taskId`.
  ///
  /// Parameter required: `taskId` from `Task`.
  List<EntryModel> retrieveEntriesByTaskId(String taskId) => _currentEntries
      .where((entryModel) => entryModel.taskId == taskId)
      .toList();

  /// **Update Entry** (`U` in CRUD)
  ///
  /// Update entry will just need to pass the `id` of the `EntryModel`
  /// & a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `ENTRY_TASK_ID`
  /// - `ENTRY_COMPLETED_DATE`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateEntry(String id, Map<String, dynamic> jsonToUpdate) {
    int _index =
        _currentEntries.indexWhere((entryModel) => entryModel.id == id);
    EntryModel _updatedEntryModel = EntryModel.fromJson({
      ..._currentEntries[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentEntries[_index] = _updatedEntryModel;
    _general.updateBoxItem(_boxType, _updatedEntryModel.id, _updatedEntryModel);
  }

  /// **Delete Entry** (`D` in CRUD)
  ///
  /// Call this function when need to delete entry
  void deleteEntry(String id) {
    int index = _currentEntries.indexWhere((entryModel) => entryModel.id == id);
    String removedId = _currentEntries.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Get the latest entry by Task ID to get the completedDate in order to
  /// check skipped tasks.
  EntryModel getLatestEntryByTaskId(String taskId) =>
      _currentEntries.lastWhere((entryModel) => entryModel.taskId == taskId);

  /// Private function to convert `List of NotificationDetail` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> entriesInListOfMap = [];
    for (EntryModel entryModel in _currentEntries) {
      entriesInListOfMap.add(entryModel.toMap());
    }
    return entriesInListOfMap;
  }
}
