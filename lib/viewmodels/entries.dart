import 'package:habyte/models/entry.dart';

class Entries {
  static final Entries _entries = Entries._internal();
  factory Entries.getInstance() => _entries;
  Entries._internal();

  final List<EntryModel> _currentEntries = [];

  void setCurrentEntries(List<Map<String, dynamic>> entryJsonList) {
    for (Map<String, dynamic> entryJson in entryJsonList) {
      _currentEntries.add(EntryModel.fromJson(entryJson));
    }
  }

  List<Map<String, dynamic>> toListOfMap() {
    List<Map<String, dynamic>> entriesInListOfMap = [];
    for (EntryModel entryModel in _currentEntries) {
      entriesInListOfMap.add(entryModel.toMap());
    }
    return entriesInListOfMap;
  }

  //// CRUD
  // C
  void createEntry(EntryModel entryModel) => _currentEntries.add(entryModel);

  // R
  List<EntryModel> retrieveAllEntries() => _currentEntries;

  // r
  // Error Handling need to do for this, either do here or do in main code
  EntryModel retrieveEntryById(String id) =>
      _currentEntries.where((entryModel) => entryModel.id == id).toList()[0];

  List<EntryModel> retrieveEntriesById(String taskId) => _currentEntries
      .where((entryModel) => entryModel.taskId == taskId)
      .toList();

  // U
  void updateEntry(String id, EntryModel updatedEntryModel) {
    int index = _currentEntries.indexWhere((entryModel) => entryModel.id == id);
    _currentEntries[index] = updatedEntryModel;
  }

  // D
  void deleteEntry(String id) =>
      _currentEntries.removeWhere((entryModel) => entryModel.id == id);
  ////
}
