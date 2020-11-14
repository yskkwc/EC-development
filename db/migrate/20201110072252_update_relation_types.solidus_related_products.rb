# This migration comes from solidus_related_products (originally 20120208144454)
class UpdateRelationTypes < ActiveRecord::Migration[4.2]
  def up
    Spree::RelationType.where(applies_to: 'Product').update_all(applies_to: 'Spree::Product')
  end

  def down
    Spree::RelationType.where(applies_to: 'Spree::Product').update_all(applies_to: 'Product')
  end
end
