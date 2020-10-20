# This migration comes from spree (originally 20160924135758)
# frozen_string_literal: true

class RemoveIsDefaultFromPrices < ActiveRecord::Migration[5.0]
  def change
    remove_column :spree_prices, :is_default, :boolean, :default => true
  end
end
