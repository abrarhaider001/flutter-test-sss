import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dio/dio.dart';
import 'package:sss/core/network/dio_client.dart';
import 'package:sss/core/database/isar_storage.dart';
import 'package:sss/core/services/auth_service.dart';

// ——— Dio (Networking) ———
final dioProvider = Provider<Dio>((ref) => createDio());

// ——— Firebase ———
final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final firebaseStorageProvider = Provider<FirebaseStorage>(
  (ref) => FirebaseStorage.instance,
);

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(firestoreProvider),
  );
});

// ——— Isar (Local DB) ———
/// Provides [IsarStorage]. On web, Isar is not supported so this throws if used.
/// Use [isarStorageProvider] and check null when on web if needed.
final isarStorageProvider = Provider<IsarStorage?>((ref) {
  if (kIsWeb) return null;
  return IsarStorage.instance;
});
