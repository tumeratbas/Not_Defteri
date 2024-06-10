import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:not_defteri_app/models/note.dart';
import 'package:not_defteri_app/services/note_service.dart';

class NoteCubit extends Cubit<List<Note>> {
  final NoteService _noteService = NoteService();

  NoteCubit() : super([]);

  Future<void> loadNotes() async {
    emit(await _noteService.loadNotes());
  }

  // Diğer işlevler için gerekli metotları buraya ekleyin
}
