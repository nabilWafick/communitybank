import 'package:communitybank/models/data/agent/agent.model.dart';
import 'package:communitybank/models/data/collection/collection.model.dart';
import 'package:communitybank/models/data/collector/collector.model.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_account/customer_account.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/product/product.model.dart';
import 'package:communitybank/models/data/settlement/settlement.model.dart';
import 'package:communitybank/models/data/type/type.model.dart';

var query =
    "je  veux obtenir pour chaque produit le nombre necessaire pour satisfaire tous les clients ayant souscrits a l'obtention de ce produit. un client est favorable a recevoir un un produit si la somme du nombre de ses reglements sur une de ses cartes ayant un type comportant ce produit est superieur ou egal a 161 ,  le nombre de produit a prendre par ce client est egal a nombre_type*nombre_produit, le calcul sera fait pour chaque carte du client ayant un type comportant ce produit, dans types se trouve les ids_produits et les nombres_produits, les ids et les nombre des produits sont ranger dans le meme ordre, (c'est a dire qu'ils ont la meme position dans leur listes respectives, ids_produits[id_produitA]=nombres_produits[nombre_produitA] dans le type). ainsi je veux pour chaque produit, l'id du produit, son nom, le nombre de produit necessaire pour satifaire tous les clients favorables, je veux egalement les ids des comptes clients des clients favorables, les id des clients favorables, les noms des clients favorables, les prenoms des clients favorables. met les ids des comptes clients favorables, les id des clients favorables, les noms des clients favorables, les prenoms des clients favorables pour chaque pour produit dans des listes et dans le meme ordre (c'est a dire ids_comptes_clients_favorables[clientA]=ids_clients_favorables[clientA]=noms_clients_favorables[clientA]=prenoms_clients_favorables[clientA])";

var exemple = 'Exemple';

final produitA = Product(
  id: 1,
  name: 'Produit A',
  purchasePrice: 150.0,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final produitB = Product(
  id: 2,
  name: 'Produit B',
  purchasePrice: 170.0,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final produitC = Product(
  id: 3,
  name: 'Produit C',
  purchasePrice: 180.0,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final produitD = Product(
  id: 4,
  name: 'Produit D',
  purchasePrice: 180.0,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final type1 = Type(
  id: 1,
  name: 'Type 1',
  stake: 50,
  productsIds: [1, 3, 4],
  productsNumber: [5, 2, 4],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final type2 = Type(
  id: 2,
  name: 'Type 2',
  stake: 150,
  productsIds: [2, 3],
  productsNumber: [1, 2],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final type3 = Type(
  id: 3,
  name: 'Type 3',
  stake: 50,
  productsIds: [2, 3, 4],
  productsNumber: [1, 1, 1],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final type4 = Type(
  id: 4,
  name: 'Type 4',
  stake: 150,
  productsIds: [1, 2],
  productsNumber: [2, 2],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final card1 = CustomerCard(
  id: 1,
  label: 'C0001',
  typeId: 1,
  typeNumber: 2,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final card2 = CustomerCard(
  id: 2,
  label: 'C0002',
  typeId: 2,
  typeNumber: 1,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final card3 = CustomerCard(
  id: 3,
  label: 'C0003',
  typeId: 3,
  typeNumber: 2,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final card4 = CustomerCard(
  id: 4,
  label: 'C0004',
  typeId: 4,
  typeNumber: 5,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final card5 = CustomerCard(
  id: 5,
  label: 'C0005',
  typeId: 1,
  typeNumber: 2,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final card6 = CustomerCard(
  id: 6,
  label: 'C0006',
  typeId: 4,
  typeNumber: 2,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final user1 = Customer(
  name: 'USER1',
  firstnames: 'User1',
  phoneNumber: '1234567890',
  address: 'Address1',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final user2 = Customer(
  name: 'USER2',
  firstnames: 'User2',
  phoneNumber: '1234567890',
  address: 'Address2',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final user3 = Customer(
  name: 'USER3',
  firstnames: 'User3',
  phoneNumber: '1234567890',
  address: 'Address3',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final collector = Collector(
  id: 1,
  name: 'COLLECTOR3',
  firstnames: 'Collector3',
  phoneNumber: '1234567890',
  address: 'Address3',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final agent = Agent(
  id: 1,
  name: 'COLLECTOR3',
  firstnames: 'Collector3',
  email: 'email@email.email',
  phoneNumber: '1234567890',
  address: 'Address3',
  role: 'Admin',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final account1 = CustomerAccount(
  id: 2,
  customerId: 1,
  collectorId: 1,
  customerCardsIds: [1, 2, 6],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final account2 = CustomerAccount(
  id: 2,
  customerId: 2,
  collectorId: 1,
  customerCardsIds: [3, 4],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final account3 = CustomerAccount(
  id: 3,
  customerId: 3,
  collectorId: 1,
  customerCardsIds: [5],
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final collection = Collection(
  id: 1,
  collectorId: 1,
  amount: 10000000,
  rest: 10000,
  agentId: 1,
  collectedAt: DateTime.now(),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

final user1Settlements = [
  // card1
  Settlement(
    number: 50,
    cardId: 1,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 115,
    cardId: 1,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 10,
    cardId: 1,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  // card2
  Settlement(
    number: 100,
    cardId: 2,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  // card6
  Settlement(
    number: 200,
    cardId: 6,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 50,
    cardId: 6,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
];

final user2Settlements = [
  // card3
  Settlement(
    number: 50,
    cardId: 3,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 175,
    cardId: 3,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 40,
    cardId: 3,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  // card4
  Settlement(
    number: 100,
    cardId: 4,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
];

final user3Settlements = [
  // card5
  Settlement(
    number: 50,
    cardId: 5,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 140,
    cardId: 5,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
  Settlement(
    number: 10,
    cardId: 5,
    agentId: 1,
    collectionId: 1,
    collectedAt: DateTime.now(),
    createdAt: DateTime.now(),
    isValiated: true,
    updatedAt: DateTime.now(),
  ),
];

var exampleExplanation =
    "Suivant l'exemple qui suit, lorsqu'on fait la somme des reglements par carte du user1, on a card1=175,card2=100,card6=250, le user1 est favorable sur card1 et card6 car la somme des reglements pour chacune de ces cartes est superieur a 161. card1=175 > 161, card6=250 > 161. Ainsi le user1 a droit aux produits du type de la card1 et aux produits du type de la card6. Or le type de card1 est type1 et le type de la card6 est est type4. dans chaque type on a les produits (productsIds) et le nombre de fois que ces produits existe dans le type (productsNumber) de telle sorte que productsIds[id_productX] = productsNumber[nombre_productX]. aussi dans chaque card nous avons le nombre de fois que le type se trouve dans la card (typeNumber) .or le type1 comporte 5*Produit1, 2*Produit3, 4*Produit4 ; le type4 comporte 2*Produit1, 2*Produit2 et la card1 comporte 2*type1, la card6 comporte 5*type4 .Ainsi, on a pour le user1 : 2*5*Produit1+5*2*Produit1, 2*2*Produit3, 2*4*Produit4 et 5*2*Produit2. Alors le user1 prendra 20*Produit1, 4*Produit3, 8*Produit4 et 10*Produit2. Je veux la requete pour faire la resolution que je viens de faire afin d'obtenir pour le nombre de produits a donner a chaque client favorable devant prendre ce produit et je veux obtenir aussi en plus de cela les clients favorables de vant prendre ce produit";
