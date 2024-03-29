-- Supabase AI is experimental and may produce incorrect answers
-- Always verify the output before executing

create
or replace function get_stocks_details (
  product_id bigint,
  agent_id bigint,
  customer_card_id bigint,
  customer_account_id bigint,
  type_id bigint,
  stock_type text,
  stock_movement_date text
) returns table (
  id_stock bigint,
  id_produit bigint,
  produit text,
  quantite_initiale int,
  quantite_entree int,
  quantite_sortie int,
  quantite_stock int,
  type varchar,
  id_agent bigint,
  agent text,
  id_carte bigint,
  libelle_carte text,
  id_type bigint,
  nom_type text,
  id_compte_client bigint,
  client text,
  date_creation timestamp with time zone,
  date_modification timestamp with time zone
) as $$
begin
return query
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
  CONCAT(agents.nom, ' ', agents.prenoms) as agent, 
  cartes.id as id_carte, 
  cartes.libelle as libelle_carte, 
  types.id as id_type, 
  types.nom as nom_type, 
  comptes_clients.id as id_compte_client, 
  CONCAT(clients.nom, ' ', clients.prenoms) as client,
  stocks.date_creation,
  stocks.date_modification
from
  stocks
  left join produits on produits.id = stocks.id_produit
  left join agents on agents.id = stocks.id_agent
  left join cartes on cartes.id = stocks.id_carte
  left join types on types.id = cartes.id_type
  left join comptes_clients on comptes_clients.id = cartes.id_compte_client
  left join clients on clients.id = comptes_clients.id_client
where
  (product_id is null or stocks.id_produit = product_id)
  and (agent_id is null or stocks.id_agent = agent_id)
  and (customer_card_id is null or stocks.id_carte = customer_card_id)
  and (customer_account_id is null or cartes.id_compte_client = customer_account_id)
  and (type_id is null or types.id = type_id)
  and (stock_type is null or stocks.type = stock_type)
  and (stock_movement_date is null or DATE(stocks.date_creation) = DATE(stock_movement_date))
order by stocks.id;
end;
$$ language plpgsql;