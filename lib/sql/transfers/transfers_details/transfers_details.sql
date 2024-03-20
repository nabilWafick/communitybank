select
    transferts.id as id_transfert,
    transferts.id_agent,
    CONCAT (agents.nom, ' ', agents.prenoms) AS agent,
    transferts.date_validation,
    transferts.date_creation,
    transferts.date_modification,
    compte_emetteur.id_carte_emettrice,
    compte_emetteur.libelle_carte_emettrice,
    compte_emetteur.id_type_emetteur,
    compte_emetteur.nom_type_emetteur,
    compte_emetteur.id_compte_client_emetteur,
    compte_emetteur.id_charge_compte_emetteur,
    compte_emetteur.charge_compte_emetteur,
    compte_emetteur.client_emetteur,
    compte_recepteur.id_carte_receptrice,
    compte_recepteur.libelle_carte_receptrice,
    compte_recepteur.id_type_recepteur,
    compte_recepteur.nom_type_recepteur,
    compte_recepteur.id_compte_client_recepteur,
    compte_recepteur.id_charge_compte_recepteur,
    compte_recepteur.charge_compte_recepteur,
    compte_recepteur.client_recepteur
from
    transferts
    INNER JOIN agents on transferts.id_agent = agents.id
    inner join (
        select
            cartes.id as id_carte_emettrice,
            cartes.libelle as libelle_carte_emettrice,
            types.id as id_type_emetteur,
            types.nom as nom_type_emetteur,
            comptes_clients.id as id_compte_client_emetteur,
            charges_compte.id as id_charge_compte_emetteur,
            CONCAT (charges_compte.nom, ' ', charges_compte.prenoms) as charge_compte_emetteur,
            clients.id as id_client_emetteur,
            CONCAT (clients.nom, ' ', clients.prenoms) as client_emetteur
        from
            cartes,
            transferts,
            types,
            comptes_clients,
            charges_compte,
            clients
        where
            cartes.id = transferts.id_carte_emettrice
            and cartes.id_type = types.id
            and cartes.id_compte_client = comptes_clients.id
            and comptes_clients.id_charge_compte = charges_compte.id
            and comptes_clients.id_client = clients.id
    ) as compte_emetteur on compte_emetteur.id_carte_emettrice = transferts.id_carte_emettrice
    inner join (
        select
            cartes.id as id_carte_receptrice,
            cartes.libelle as libelle_carte_receptrice,
            types.id as id_type_recepteur,
            types.nom as nom_type_recepteur,
            comptes_clients.id as id_compte_client_recepteur,
            charges_compte.id as id_charge_compte_recepteur,
            CONCAT (charges_compte.nom, ' ', charges_compte.prenoms) as charge_compte_recepteur,
            clients.id as id_client_recepteur,
            CONCAT (clients.nom, ' ', clients.prenoms) as client_recepteur
        from
            cartes,
            transferts,
            types,
            comptes_clients,
            charges_compte,
            clients
        where
            cartes.id = transferts.id_carte_receptrice
            and cartes.id_type = types.id
            and cartes.id_compte_client = comptes_clients.id
            and comptes_clients.id_charge_compte = charges_compte.id
            and comptes_clients.id_client = clients.id
    ) as compte_recepteur on compte_recepteur.id_carte_receptrice = transferts.id_carte_receptrice;