import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:desafio_konsi/app/core/services/get_it/service_locator.dart';
import 'package:desafio_konsi/app/core/states/base_state.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/controllers/revision_controller.dart';
import 'package:desafio_konsi/app/screens/revision/interactors/dtos/revision_dto.dart';
import 'package:desafio_konsi/app/screens/revision/widgets/revision_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, child) {
              return switch (state) {
                InitialState() => CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: SvgPicture.asset(
                                        'assets/svgs/arrow_back.svg')),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Revisão',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.mainTextColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.75,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                    keyboardType: TextInputType.number,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                switch (widget.revisionDto.type) {
                                  case RevisionType.add:
                                    controller.addLocation(
                                      onSuccess: () {
                                        context.go('/favorites');
                                      },
                                      selectedLocation:
                                          widget.revisionDto.location,
                                      number: controller
                                          .numberController.value.text,
                                      complement: controller
                                          .complementController.value.text,
                                    );
                                    break;
                                  case RevisionType.update:
                                    controller.updateLocation(
                                      onSuccess: () {
                                        context.go('/favorites');
                                      },
                                      selectedLocation:
                                          widget.revisionDto.location,
                                      number: controller
                                          .numberController.value.text,
                                      complement: controller
                                          .complementController.value.text,
                                    );
                                    break;
                                  default:
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              'Confirmar',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
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
      ),
    );
  }
}
