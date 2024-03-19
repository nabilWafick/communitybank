class TransferDetailRPC {
  static const String functionName = 'transfers_details';

  static const String transferId = 'id_transfer';
  static const String issuingCustomerCardId = 'id_carte_emettrice';
  static const String issuingCustomerCardLabel = 'libelle_carte_emettrice';
  static const String issuingCustomerCardTypeId = 'id_type_emetteur';
  static const String issuingCustomerCardTypeName = 'nom_type_emetteur';
  static const String issuingCustomerAccountId = 'id_compte_client_emetteur';
  static const String issuingCustomerCollectorId = 'id_charge_compte_emetteur';
  static const String issuingCustomerCollector = 'charge_compte_emetteur';
  static const String issuingCustomer = 'client_emetteur';
  static const String receivingCustomerCardId = 'id_carte_receptrice';
  static const String receivingCustomerCardLabel = 'libelle_carte_receptrice';
  static const String receivingCustomerCardTypeId = 'id_type_recepteur';
  static const String receivingCustomerCardTypeName = 'nom_type_recepteur';
  static const String receivingCustomerAccountId = 'id_compte_client_recepteur';
  static const String receivingCustomerCollectorId =
      'id_charge_compte_recepteur';
  static const String receivingCustomerCollector = 'charge_compte_recepteur';
  static const String receivingCustomer = 'client_recepteur';
  static const String agentId = 'id_agent';
  static const String validatedAt = 'date_validation';
  static const String createdAt = 'date_creation';
  static const String updatedAt = 'date_modification';
}
