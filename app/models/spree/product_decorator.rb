module Spree::ProductDecorator
  def related_products
    Spree::Product.in_taxons(taxons).
      distinct.where.not(id: id).
      includes(master: [:default_price, :images]).
      sample(Constants::DISPLAY_RELATED_PRODUCTS_COUNT)
  end
  Spree::Product.prepend self
end
