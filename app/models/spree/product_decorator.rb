module Spree::ProductDecorator
  def related_products
    Spree::Product.in_taxons(taxons).
      distinct.where.not(id: id).
      includes(master: [:default_price, :images]).
      limit(Constants::RELATED_PRODUCTS_LIMIT_COUNT).shuffle.
      take(Constants::DISPLAY_RELATED_PRODUCTS_MAX_COUNT)
  end
  Spree::Product.prepend self
end
