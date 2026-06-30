import 'package:amsl_app/features/preferences/storage_keys.dart';
import 'package:amsl_app/features/preferences/storages.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_card_order_provider.g.dart';

enum HomeCardId { journal, module, planner, selfManagement }

extension HomeCardIdMetadata on HomeCardId {
  IconData get icon => switch (this) {
    HomeCardId.journal => Icons.book_outlined,
    HomeCardId.module => Icons.school_outlined,
    HomeCardId.planner => Icons.calendar_today_outlined,
    HomeCardId.selfManagement => Icons.insights_outlined,
  };

  String get label => switch (this) {
    HomeCardId.journal => 'Lernjournal',
    HomeCardId.module => 'Module',
    HomeCardId.planner => 'Planner',
    HomeCardId.selfManagement => 'Selbstmanagement',
  };
}

const _defaultOrder = [
  HomeCardId.journal,
  HomeCardId.module,
  HomeCardId.planner,
  HomeCardId.selfManagement,
];

@Riverpod(keepAlive: true, dependencies: [storages])
class HomeCardOrder extends _$HomeCardOrder {
  @override
  List<HomeCardId> build() {
    final prefs = ref.watch(storagesProvider).shared;
    final raw = prefs.getString(StorageKey.homeCardOrder.key);
    if (raw == null) return _defaultOrder;
    final byName = HomeCardId.values.asNameMap();
    final parsed = raw
        .split(',')
        .map((n) => byName[n])
        .whereType<HomeCardId>()
        .toList();
    for (final id in _defaultOrder) {
      if (!parsed.contains(id)) parsed.add(id);
    }
    return parsed;
  }

  void reorder(int oldIndex, int newIndex) {
    final list = [...state];
    if (newIndex > oldIndex) newIndex--;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    ref
        .read(storagesProvider)
        .shared
        .setString(
          StorageKey.homeCardOrder.key,
          list.map((e) => e.name).join(','),
        );
    state = list;
  }
}
