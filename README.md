# desafio_konsi

## Versões Necessárias

- **Dart**: ![Dart Version](https://img.shields.io/static/v1?label=Dart&amp;message=3.5.3&amp;color=blue&amp;logo=dart)
  [Documentação Oficial do Dart](https://dart.dev)

- **Flutter**: ![Flutter Version](https://img.shields.io/static/v1?label=Flutter&amp;message=3.24.3&amp;color=blue&amp;logo=flutter)
  [Documentação Oficial do Flutter](https://docs.flutter.dev/get-started/install)


### Tecnologias e Pacotes Utilizados

- [Get It](https://pub.dev/packages/get_it): Para injeção de dependências.
- [Go Router](https://pub.dev/packages/go_router): Gerenciamento de rotas no app.
- [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html): Utilizado para gerenciar estados dentro do app.
- [Google Maps](https://pub.dev/packages/google_maps_flutter): Utilizado para obter o mapa do mundo.
- [SQfLite](https://pub.dev/packages/sqflite): Utilizado para ter um banco de dados local e fazer um insert/query/update/delete.
- [Geocoding](https://pub.dev/packages/geocoding): API para obter dados de uma área a partir da Latitude e Longitude ou Endereço.
- [Geolocator](https://pub.dev/packages/geolocator): Permissão de localização atual do dispositivo.

### Demonstração do projeto

Uma apresentação visual das funções do aplicativo

## Inicialização
![init](https://github.com/user-attachments/assets/04c96696-cf89-4351-87af-1299d3f9f1fc)

## Selecionar localização no mapa
![select_location](https://github.com/user-attachments/assets/758815c3-8a19-42ff-ba2f-0add4104921d)

## Selecionar localização por input
![select_location_input](https://github.com/user-attachments/assets/728c385d-504c-4c0d-a037-2f7ba61bda32)

## Adicionar localização a caderneta
![add_location](https://github.com/user-attachments/assets/980d0f38-5ddc-4277-bfbe-a4bd4cfe11f1)

## Adicionar localização a caderneta por input
![add_location_input](https://github.com/user-attachments/assets/84f58747-8a87-4c43-94fd-4df6e6a56e72)

## Atualizar localização da caderneta
![update_location](https://github.com/user-attachments/assets/a3d3e500-45d0-4a37-919e-059ebf31aaa6)

## Apagar localizações da caderneta
![delete_location](https://github.com/user-attachments/assets/b61f5862-b7f2-4255-a9c7-b4200a49b9ef)

## Navegação pelo mapa
![flinch (1)](https://github.com/user-attachments/assets/293c8587-59c3-4e1f-a8f4-db4a76f566ef)


### Estrutura do projeto

```
app
├── core
│   ├── constants
│   ├── controllers
│   ├── entities
│   ├── errors
│   ├── extensions
│   ├── services
│   ├── states
│   ├── theme
│   ├── types
│   └── usecases
├── features
│   ├── locations
│   │   ├── data
│   │   │   ├── adapters
│   │   │   ├── datasources
│   │   │   └── repositories
│   │   └── domain
│   │       ├── entities
│   │       ├── models
│   │       ├── repositories
│   │       └── usecases
├── screens
│   ├── revision
│   ├── shell
│   │   ├── favorites
│   │   ├── maps
│   │   └── widgets
│   ├── splash
│   └── widgets

