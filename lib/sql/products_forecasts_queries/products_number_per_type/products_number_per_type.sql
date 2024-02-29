-- PRODUCT NUMBER PER TYPE QUERY
SELECT
  produits.id as id_produit,
  produits.nom as nom_produit,
  produits.prix_achat as prix_achat_produit,
  coalesce(array_agg(details_types.id_type), array[]::bigint[]) as ids_types,
  coalesce(array_agg(details_types.nom_type), array[]::text[]) as noms_types,
  coalesce(
    array_agg(details_types.nombre_produit_type),
    array[]::int[]
  ) as nombres_produits_types
FROM
  produits
  LEFT JOIN (
    SELECT
      id as id_type,
      nom as nom_type,
      unnest(ids_produits) AS id_produit_type,
      unnest(nombres_produits) AS nombre_produit_type
    FROM
      types
    GROUP BY
      id_type
  ) as details_types on details_types.id_produit_type = produits.id
GROUP BY
  produits.id,
  produits.nom
ORDER BY 
  produits.nom ASC;