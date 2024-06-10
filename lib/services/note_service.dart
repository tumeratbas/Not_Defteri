import 'dart:convert';

import 'package:not_defteri_app/models/note.dart';
import 'package:not_defteri_app/services/api_service.dart';
import 'package:not_defteri_app/services/cache_service.dart';

class NoteService {
  final ApiService _apiService = ApiService();
  final CacheService _cacheService = CacheService();

  Future<List<Note>> loadNotes() async {
    final cachedNotes = await _cacheService.readNotes();
    if (cachedNotes != null) {
      final List<dynamic> jsonResponse = json.decode(cachedNotes);
      return jsonResponse.map((note) => Note.fromJson(note)).toList();
    }

    final notes = await _apiService.fetchNotes();
    await _cacheService.writeNotes(json.encode(notes.map((note) => note.toJson()).toList()));

    return notes;
  }

  Future<void> addNote(Note note) async {
    await _apiService.addNote(note);
    final notes = await loadNotes();
    await _cacheService.writeNotes(json.encode(notes.map((note) => note.toJson()).toList()));
  }

  Future<void> updateNote(Note note) async {
    await _apiService.updateNote(note);
    final notes = await loadNotes();
    await _cacheService.writeNotes(json.encode(notes.map((note) => note.toJson()).toList()));
  }

  Future<void> deleteNote(int id) async {
    await _apiService.deleteNote(id);
    final notes = await loadNotes();
    await _cacheService.writeNotes(json.encode(notes.map((note) => note.toJson()).toList()));
  }
}
