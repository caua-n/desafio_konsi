import 'dart:async';

import 'package:flutter/foundation.dart';

import '../states/base_state.dart';

/// A classe abstrata `BaseController` é projetada para gerenciar e notificar
/// alterações de estado utilizando a classe `ValueNotifier`.
///
/// [T] representa o tipo de estado que o controlador gerencia e deve estender
/// `BaseState`.
/// Essa classe pode usar builder como [ValueListenableBuilder],
/// [ListenableBuilder] ou [AnimatedBuilder].
abstract class BaseController<T extends BaseState>
    implements ValueListenable<T> {
  late final ValueNotifier<T> _stateNotifier;

  /// Obtém o estado atual mantido pelo `_stateNotifier`.
  T get state => _stateNotifier.value;

  /// Obtém o estado atual mantido pelo `_stateNotifier`.
  @override
  T get value => _stateNotifier.value;

  /// Cria uma instância de `BaseController` com um estado inicial fornecido.
  ///
  /// [initialState] O estado inicial para o controlador.
  BaseController(T initialState) {
    _stateNotifier = ValueNotifier<T>(initialState);
    initController();
  }

  @mustCallSuper
  initController() {}

  /// Converte de [BaseController] para [stream].
  Stream<T> asStream() {
    late StreamController<T> controller;

    void listen() {
      controller.add(_stateNotifier.value);
    }

    controller = StreamController<T>(
      onListen: () {
        _stateNotifier.addListener(listen);
      },
      onCancel: () {
        _stateNotifier.removeListener(listen);
      },
    );

    return controller.stream;
  }

  /// Adiciona um listener que será chamado sempre que o estado mudar.
  ///
  /// [listener] A função de callback a ser chamada nas mudanças de estado.
  @override
  void addListener(VoidCallback listener) {
    _stateNotifier.addListener(listener);
  }

  /// Remove um listener previamente adicionado.
  ///
  /// [listener] A função de callback a ser removida.
  @override
  void removeListener(VoidCallback listener) {
    _stateNotifier.removeListener(listener);
  }

  /// Atualiza o estado atual com um novo estado.
  ///
  /// [newState] O novo estado para atualizar.
  void update(T newState) {
    middleware(newState);
  }

  void _update(T newState) {
    _stateNotifier.value = newState;
  }

  /// Middleware para interceptar o estado antes de atualizar.
  @protected
  void middleware(T newState) {
    _update(newState);
  }

  /// Libera os recursos.
  void dispose() {
    _stateNotifier.dispose();
  }
}
