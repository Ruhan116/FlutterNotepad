import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app.dart';

/// MAIN ENTRY POINT
///
/// Initialize database for desktop platforms before running app
void main() {
  // DESKTOP DATABASE INITIALIZATION
  // SQLite needs special setup on Windows/Linux/macOS
  //
  // Why? Mobile (iOS/Android) has built-in SQLite
  // Desktop needs sqflite_common_ffi (FFI = Foreign Function Interface)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI
    sqfliteFfiInit();

    // Set global database factory
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const ProviderScope(child: MyApp()));
}
