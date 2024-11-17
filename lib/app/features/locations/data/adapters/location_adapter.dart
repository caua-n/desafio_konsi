import '../../domain/entities/location_entity.dart';

class LocationAdapter extends LocationEntity {
  LocationAdapter({
    required int id,
    required int cep,
    required String address,
    required int addressNumber,
    required String complement,
  }) : super(id,
            cep: cep,
            address: address,
            addressNumber: addressNumber,
            complement: complement);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cep': cep,
      'address': address,
      'address_number': addressNumber,
      'complement': complement,
    };
  }

  factory LocationAdapter.fromMap(Map<String, dynamic> map) {
    return LocationAdapter(
      id: map['id'],
      cep: map['cep'],
      address: map['address'],
      addressNumber: map['address_number'],
      complement: map['complement'],
    );
  }
}
