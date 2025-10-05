import 'package:go_router/go_router.dart';
import 'package:notepad/features/notes/presentation/notes_list_screen.dart';
import 'package:notepad/features/note/presentation/add_note_screen.dart';
import 'package:notepad/features/settings/presentation/settings_screen.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NotesListScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/add_note',
      builder: (context, state) => const AddNoteScreen(),
    ),
  ],
);
