select
    stocks.id as id_stock,
    stocks.id_produit as id_produit,
    produits.nom as produit,
    COALESCE(stocks.quantite_initiale, 0) as quantite_initiale,
    COALESCE(stocks.quantite_entree, 0) as quantite_entree,
    COALESCE(stocks.quantite_sortie, 0) as quantite_sortie,
    COALESCE(stocks.quantite_stock, 0) as quantite_stock,
    stocks.type,
    agents.id as id_agent,
    CONCAT (agents.nom, ' ', agents.prenoms) as agent,
    cartes.id as id_carte,
    cartes.libelle as libelle_carte,
    types.id as id_type,
    types.nom as nom_type,
    comptes_clients.id as id_compte_client,
    CONCAT (clients.nom, ' ', clients.prenoms) as client
from
    stocks
    left join produits on produits.id = stocks.id_produit
    left join agents on agents.id = stocks.id_agent
    left join cartes on cartes.id = stocks.id_carte
    left join types on types.id = cartes.id_type
    left join comptes_clients on comptes_clients.id = cartes.id_compte_client
    left join clients on clients.id = comptes_clients.id_client
order by
    stocks.id;