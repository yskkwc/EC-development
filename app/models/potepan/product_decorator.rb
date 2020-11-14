module Spree::ProductDecorator
  def related_products
    Spree::Product.in_taxons(taxons).where.not(id: id).distinct.limit(4).order(Arel.sql("RAND()"))
  end
  Spree::Product.prepend self
end
