-- SETTLEMENT TOTAL PER CUSTOMER PER CUSTOMER CARD PER PRODUCT
SELECT
  produits.id AS id_produit,
  produits.nom AS nom_produit,
  COALESCE(ARRAY_AGG(types.id), ARRAY[]::bigint[]) AS ids_types,
  COALESCE(ARRAY_AGG(types.nom), ARRAY[]::text[]) AS noms_types,
  COALESCE(ARRAY_AGG(cartes.id), ARRAY[]::bigint[]) AS ids_cartes,
  COALESCE(ARRAY_AGG(cartes.libelle), ARRAY[]::text[]) AS libelles_cartes,
  COALESCE(ARRAY_AGG(cartes.nombre_types), ARRAY[]::int[]) AS nombres_types,
  COALESCE(
    ARRAY_AGG(COALESCE(bilan_reglements.total_reglements, 0)),
    ARRAY[]::int[]
  ) AS totaux_reglements_cartes,
  COALESCE(ARRAY_AGG(comptes_clients.id), ARRAY[]::bigint[]) AS ids_comptes_clients,
  COALESCE(ARRAY_AGG(charges_compte.id), ARRAY[]::bigint[]) AS ids_charges_compte,
  COALESCE(ARRAY_AGG(charges_compte.nom), ARRAY[]::text[]) AS noms_charges_compte,
  COALESCE(
    ARRAY_AGG(charges_compte.prenoms),
    ARRAY[]::text[]
  ) AS prenoms_charges_compte,
  COALESCE(ARRAY_AGG(clients.id), ARRAY[]::bigint[]) AS ids_clients,
  COALESCE(ARRAY_AGG(clients.nom), ARRAY[]::text[]) AS noms_clients,
  COALESCE(ARRAY_AGG(clients.prenoms), ARRAY[]::text[]) AS prenoms_clients
FROM
  produits
  LEFT JOIN types ON produits.id = ANY (types.ids_produits)
  LEFT JOIN cartes ON types.id = cartes.id_type
  LEFT JOIN comptes_clients ON cartes.id = ANY (comptes_clients.ids_cartes)
  LEFT JOIN clients ON comptes_clients.id_client = clients.id
  LEFT JOIN charges_compte ON comptes_clients.id_charge_compte = charges_compte.id
  LEFT JOIN (
    SELECT
      id_carte,
      COALESCE(
        SUM(
          CASE
            WHEN est_valide THEN nombre
            ELSE 0
          END
        ),
        0
      ) AS total_reglements
    FROM
      reglements
    GROUP BY
      id_carte
  ) AS bilan_reglements ON bilan_reglements.id_carte = cartes.id
  --	WHERE
  --  bilan_reglements.total_reglements >= 10
  --  produits.id = product_id OR product_id IS NULL
  --  and comptes_clients.id = customer_account_id OR customer_account_id IS NULL
GROUP BY
  produits.id,
  produits.nom
ORDER BY
  produits.nom ASC;