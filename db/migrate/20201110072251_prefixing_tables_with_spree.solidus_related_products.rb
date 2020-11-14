# This migration comes from solidus_related_products (originally 20111129044813)
class PrefixingTablesWithSpree < ActiveRecord::Migration[4.2]
  def change
    rename_table :relation_types, :spree_relation_types
    rename_table :relations, :spree_relations
  end
end
