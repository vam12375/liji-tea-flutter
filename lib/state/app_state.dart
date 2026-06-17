import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/sample_data.dart';
import '../models/tea_product.dart';

class AppState extends ChangeNotifier {
  AppState._(this._prefs) {
    _load();
  }

  static Future<AppState> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AppState._(prefs);
  }

  static const _cartKey = 'cart_items';
  static const _favoritesKey = 'favorite_ids';
  static const _searchHistoryKey = 'search_history';
  static const _loggedInKey = 'logged_in';
  static const _phoneKey = 'phone';
  static const _themeModeKey = 'theme_mode';
  static const _notificationsKey = 'notifications_enabled';

  final SharedPreferences _prefs;

  final List<CartLine> _cart = [];
  final Set<String> _favoriteIds = <String>{};
  final List<String> _searchHistory = [];

  bool _isLoggedIn = false;
  String? _phone;
  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;

  List<CartLine> get cart => List.unmodifiable(_cart);
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);
  List<String> get searchHistory => List.unmodifiable(_searchHistory);
  bool get isLoggedIn => _isLoggedIn;
  String? get phone => _phone;
  ThemeMode get themeMode => _themeMode;
  bool get notificationsEnabled => _notificationsEnabled;

  int get cartCount => _cart.fold(0, (sum, line) => sum + line.quantity);

  int get cartTotal {
    return _cart.fold(0, (sum, line) {
      if (!line.selected) return sum;
      return sum + line.product.price * line.quantity;
    });
  }

  bool get allCartSelected => _cart.isNotEmpty && _cart.every((line) => line.selected);

  List<CartItem> get selectedCartItems {
    return [
      for (final line in _cart)
        if (line.selected)
          CartItem(product: line.product, spec: line.spec, quantity: line.quantity),
    ];
  }

  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  void addToCart(TeaProduct product, String spec, {int quantity = 1}) {
    final index = _cart.indexWhere((line) => line.product.id == product.id && line.spec == spec);
    if (index == -1) {
      _cart.add(CartLine(product: product, spec: spec, quantity: quantity));
    } else {
      _cart[index] = _cart[index].copyWith(quantity: _cart[index].quantity + quantity);
    }
    _saveCart();
    notifyListeners();
  }

  void removeFromCart(String productId, String spec) {
    _cart.removeWhere((line) => line.product.id == productId && line.spec == spec);
    _saveCart();
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    _saveCart();
    notifyListeners();
  }

  void clearSelectedCart() {
    _cart.removeWhere((line) => line.selected);
    _saveCart();
    notifyListeners();
  }

  void setCartLineSelected(String productId, String spec, bool selected) {
    final index = _cart.indexWhere((line) => line.product.id == productId && line.spec == spec);
    if (index == -1) return;
    _cart[index] = _cart[index].copyWith(selected: selected);
    _saveCart();
    notifyListeners();
  }

  void setAllCartSelected(bool selected) {
    for (var i = 0; i < _cart.length; i++) {
      _cart[i] = _cart[i].copyWith(selected: selected);
    }
    _saveCart();
    notifyListeners();
  }

  void setCartQuantity(String productId, String spec, int quantity) {
    final index = _cart.indexWhere((line) => line.product.id == productId && line.spec == spec);
    if (index == -1) return;
    if (quantity <= 0) {
      _cart.removeAt(index);
    } else {
      _cart[index] = _cart[index].copyWith(quantity: quantity);
    }
    _saveCart();
    notifyListeners();
  }

  void toggleFavorite(String productId) {
    if (!_favoriteIds.add(productId)) {
      _favoriteIds.remove(productId);
    }
    _saveFavorites();
    notifyListeners();
  }

  void removeFavorite(String productId) {
    if (!_favoriteIds.remove(productId)) return;
    _saveFavorites();
    notifyListeners();
  }

  void addSearchHistory(String keyword) {
    final normalized = keyword.trim();
    if (normalized.isEmpty) return;
    _searchHistory.remove(normalized);
    _searchHistory.insert(0, normalized);
    if (_searchHistory.length > 10) {
      _searchHistory.removeRange(10, _searchHistory.length);
    }
    _saveSearchHistory();
    notifyListeners();
  }

  void clearSearchHistory() {
    _searchHistory.clear();
    _saveSearchHistory();
    notifyListeners();
  }

  void signIn(String phone) {
    _isLoggedIn = true;
    _phone = phone.trim();
    _prefs.setBool(_loggedInKey, _isLoggedIn);
    _prefs.setString(_phoneKey, _phone ?? '');
    notifyListeners();
  }

  void signOut() {
    _isLoggedIn = false;
    _phone = null;
    _prefs.setBool(_loggedInKey, _isLoggedIn);
    _prefs.remove(_phoneKey);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _prefs.setString(_themeModeKey, mode.name);
    notifyListeners();
  }

  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    _prefs.setBool(_notificationsKey, enabled);
    notifyListeners();
  }

  void _load() {
    _loadCart();
    _favoriteIds
      ..clear()
      ..addAll(_prefs.getStringList(_favoritesKey) ?? <String>[
        SampleData.longjing.id,
        SampleData.dahongpao.id,
        SampleData.baihaoYinzhen.id,
        SampleData.shanshuiPot.id,
      ]);
    _searchHistory
      ..clear()
      ..addAll(_prefs.getStringList(_searchHistoryKey) ?? SampleData.searchHistory);
    _isLoggedIn = _prefs.getBool(_loggedInKey) ?? true;
    _phone = _prefs.getString(_phoneKey) ?? '188 8888 8888';
    _notificationsEnabled = _prefs.getBool(_notificationsKey) ?? true;
    _themeMode = switch (_prefs.getString(_themeModeKey)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  void _loadCart() {
    final saved = _prefs.getStringList(_cartKey);
    _cart.clear();
    if (saved == null) {
      _cart.addAll([
        for (final item in SampleData.cart)
          CartLine(product: item.product, spec: item.spec, quantity: item.quantity),
      ]);
      return;
    }
    for (final raw in saved) {
      try {
        final json = jsonDecode(raw) as Map<String, dynamic>;
        final product = SampleData.productById(json['productId'] as String? ?? '');
        if (product == null) continue;
        _cart.add(CartLine(
          product: product,
          spec: json['spec'] as String? ?? product.unit,
          quantity: json['quantity'] as int? ?? 1,
          selected: json['selected'] as bool? ?? true,
        ));
      } on FormatException {
        continue;
      }
    }
  }

  void _saveCart() {
    _prefs.setStringList(_cartKey, [
      for (final line in _cart)
        jsonEncode({
          'productId': line.product.id,
          'spec': line.spec,
          'quantity': line.quantity,
          'selected': line.selected,
        }),
    ]);
  }

  void _saveFavorites() {
    _prefs.setStringList(_favoritesKey, _favoriteIds.toList());
  }

  void _saveSearchHistory() {
    _prefs.setStringList(_searchHistoryKey, _searchHistory);
  }
}

class CartLine {
  const CartLine({
    required this.product,
    required this.spec,
    required this.quantity,
    this.selected = true,
  });

  final TeaProduct product;
  final String spec;
  final int quantity;
  final bool selected;

  CartLine copyWith({
    TeaProduct? product,
    String? spec,
    int? quantity,
    bool? selected,
  }) {
    return CartLine(
      product: product ?? this.product,
      spec: spec ?? this.spec,
      quantity: quantity ?? this.quantity,
      selected: selected ?? this.selected,
    );
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState state,
    required super.child,
  }) : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No AppStateScope found in context');
    return scope!.notifier!;
  }
}
