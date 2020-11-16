module Spree::ProductDecorator
  DISPLAY_RELATED_PRODUCTS_COUNT = 4

  def related_products
    Spree::Product.in_taxons(taxons).
      where.not(id: id).distinct.
      limit(DISPLAY_RELATED_PRODUCTS_COUNT).
      order(Arel.sql("RAND()"))
  end
  Spree::Product.prepend self
end
