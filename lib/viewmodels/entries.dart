import 'package:habyte/models/entry.dart';
import 'package:habyte/viewmodels/general.dart';

class Entries {
  static final Entries _entries = Entries._internal();
  factory Entries.getInstance() => _entries;
  Entries._internal();

  BoxType boxType = BoxType.entry;

  final General _general = General.getInstance();

  late final List<EntryModel> _currentEntries;

  void setCurrentEntries(List<EntryModel> entryModelList) {
    _currentEntries = entryModelList;
  }

  List<Map<String, dynamic>> _toListOfMap() {
    List<Map<String, dynamic>> entriesInListOfMap = [];
    for (EntryModel entryModel in _currentEntries) {
      entriesInListOfMap.add(entryModel.toMap());
    }
    return entriesInListOfMap;
  }

  //// CRUD
  // C
  void createEntry(EntryModel entryModel) {
    entryModel.id = _general.getBoxItemNewId(boxType);
    _currentEntries.add(entryModel);
    _general.addBoxItem(boxType, entryModel.id, entryModel);
  }

  // R
  List<EntryModel> retrieveAllEntries() => _currentEntries;
  List<Map<String, dynamic>> retrieveAllEntriesInListOfMap() => _toListOfMap();

  // r
  EntryModel retrieveEntryById(String id) =>
      _currentEntries.singleWhere((entryModel) => entryModel.id == id);

  List<EntryModel> retrieveEntriesById(String taskId) => _currentEntries
      .where((entryModel) => entryModel.taskId == taskId)
      .toList();

  // U
  void updateEntry(String id, EntryModel updatedEntryModel) {
    int index = _currentEntries.indexWhere((entryModel) => entryModel.id == id);
    updatedEntryModel.id = _currentEntries[index].id;
    _currentEntries[index] = updatedEntryModel;
    _general.updateBoxItem(boxType, updatedEntryModel.id, updatedEntryModel);
  }

  // D
  void deleteEntry(String id) {
    int index = _currentEntries.indexWhere((entryModel) => entryModel.id == id);
    String removedId = _currentEntries.removeAt(index).id;
    _general.deleteBoxItem(boxType, removedId);
  }
  ////
}
