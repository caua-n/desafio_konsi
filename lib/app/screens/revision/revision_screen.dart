import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/controllers/revision_controller.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/revision/widgets/revision_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RevisionScreen extends StatefulWidget {
  final RevisionDto revisionDto;
  const RevisionScreen({
    super.key,
    required this.revisionDto,
  });

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  late final RevisionControllerImpl controller;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = sl<RevisionControllerImpl>();
    controller.addListener(listener);
    initialText();
  }

  void initialText() {
    final dto = widget.revisionDto;
    controller.postalCodeController.text = dto.location.postalCode;
    controller.addressController.text = dto.location.street;
  }

  void listener() {}

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Revisão'),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, state, child) {
            return switch (state) {
              InitialState() => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFieldWidget(
                                textEditingController:
                                    controller.postalCodeController,
                                readOnly: true,
                                enabled: false,
                                labelText: 'CEP',
                                hintText: '',
                              ),
                              const SizedBox(height: 16),
                              TextFieldWidget(
                                textEditingController:
                                    controller.addressController,
                                readOnly: true,
                                enabled: false,
                                labelText: 'Endereço',
                                hintText: '',
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 16),
                              TextFieldWidget(
                                textEditingController:
                                    controller.numberController,
                                readOnly: false,
                                autoFocus: true,
                                labelText: 'Número',
                                hintText: ' ',
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'O número é obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFieldWidget(
                                textEditingController:
                                    controller.complementController,
                                readOnly: false,
                                labelText: 'Complemento',
                                hintText: ' ',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'O complemento é obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    controller.addLocation(
                                      context,
                                      selectedLocation:
                                          widget.revisionDto.location,
                                      number: controller
                                          .numberController.value.text,
                                      complement: controller
                                          .complementController.value.text,
                                    );
                                  }
                                },
                                child: const Text('Enviar'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ErrorState(:final exception) =>
                Center(child: Text('Erro: $exception')),
              _ => Center(child: Text('Estado desconhecido: $state')),
            };
          }),
    );
  }
}
