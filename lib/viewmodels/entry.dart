import 'package:habyte/models/entry.dart';
import 'package:habyte/viewmodels/general.dart';

/// **Entry ViewModel Class**
///
/// Involves:
/// - Entry Model
/// - CRUD
/// - Other operations
class EntryVM {
  static final EntryVM _entryVM = EntryVM._internal();
  EntryVM._internal();

  /// Get the `Entry` instance for user `CRUD` and other operations
  factory EntryVM.getInstance() => _entryVM;

  final General _general = General.getInstance();
  final BoxType _boxType = BoxType.entry;
  List<Entry> _currentEntries = [];

  /// Everytime login, `retrievePreviousLogin()` in general need to call this
  /// to insert the data stored.
  void setCurrentEntries(List<Entry> entryList) => _currentEntries = entryList;

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
    Entry _entry = Entry.fromJson(entryJson);
    _entry.id = _general.getBoxItemNewId(_boxType);
    _currentEntries.add(_entry);
    _general.addBoxItem(_boxType, _entry.id, _entry);
  }

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Entry`.
  List<Entry> retrieveAllEntries() => _currentEntries;

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Map`
  /// (converted from `Entry`).
  List<Map<String, dynamic>> retrieveAllEntriesInListOfMap() => _toListOfMap();

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info from one of the `Entry`.
  ///
  /// Parameter required: `id` from `Entry`.
  Entry retrieveEntryById(String id) =>
      _currentEntries.singleWhere((entry) => entry.id == id);

  /// **Retrieve Entry** (`R` in CRUD)
  ///
  /// Call this function when you need the info in `List of Entry` from `taskId`.
  ///
  /// Parameter required: `taskId` from `Task`.
  List<Entry> retrieveEntriesByTaskId(String taskId) =>
      _currentEntries.where((entry) => entry.taskId == taskId).toList();

  /// **Update Entry** (`U` in CRUD)
  ///
  /// Update entry will just need to pass the `id` of the `Entry`
  /// & a map with the key and value that need to update
  ///
  /// Below are the fields that can be updated:
  /// - `ENTRY_TASK_ID`
  /// - `ENTRY_COMPLETED_DATE`
  ///
  /// **Remark:** Above keys are gotten from `constant.dart`. Kindly import
  /// from there
  void updateEntry(String id, Map<String, dynamic> jsonToUpdate) {
    int _index = _currentEntries.indexWhere((entry) => entry.id == id);
    Entry _updatedEntry = Entry.fromJson({
      ..._currentEntries[_index].toMap(),
      ...jsonToUpdate,
    });
    _currentEntries[_index] = _updatedEntry;
    _general.updateBoxItem(_boxType, _updatedEntry.id, _updatedEntry);
  }

  /// **Delete Entry** (`D` in CRUD)
  ///
  /// Call this function when need to delete entry
  void deleteEntry(String id) {
    int index = _currentEntries.indexWhere((entry) => entry.id == id);
    String removedId = _currentEntries.removeAt(index).id;
    _general.deleteBoxItem(_boxType, removedId);
  }

  /// Get the latest entry by Task ID to get the completedDate in order to
  /// check skipped tasks.
  Entry getLatestEntryByTaskId(String taskId) =>
      _currentEntries.lastWhere((entry) => entry.taskId == taskId);

  /// Private function to convert `List of Entry` to `List of Map`
  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> entriesInListOfMap = [];
    for (Entry entry in _currentEntries) {
      entriesInListOfMap.add(entry.toMap());
    }
    return entriesInListOfMap;
  }
}
