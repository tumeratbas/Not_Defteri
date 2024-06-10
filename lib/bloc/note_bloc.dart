import 'package:bloc/bloc.dart';
import 'package:not_defteri_app/models/note.dart';
import 'package:not_defteri_app/services/note_service.dart';

enum NoteEvent { loadNotes, addNote, updateNote, deleteNote }

class NoteBloc extends Bloc<NoteEvent, List<Note>> {
  final NoteService _noteService = NoteService();

  NoteBloc() : super([]);

  @override
  Stream<List<Note>> mapEventToState(NoteEvent event) async* {
    switch (event) {
      case NoteEvent.loadNotes:
        yield await _noteService.loadNotes();
        break;
      case NoteEvent.addNote:
        // Note eklemek için gerekli işlemleri burada yapın
        break;
      case NoteEvent.updateNote:
        // Note güncellemek için gerekli işlemleri burada yapın
        break;
      case NoteEvent.deleteNote:
        // Note silmek için gerekli işlemleri burada yapın
        break;
    }
  }
}
