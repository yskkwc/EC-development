RSpec.describe Spree::ProductDecorator, type: :model do
  let(:taxon) { create(:taxon) }
  let!(:not_related_product) { create(:product, taxons: [create(:taxon)]) }

  describe "related products" do
    let(:product) { create(:product, taxons: [taxon]) }

    context "when have 5 related products" do
      let!(:related_products) do
        create_list(:product, Constants::DISPLAY_RELATED_PRODUCTS_MAX_COUNT + 1, taxons: [taxon])
      end

      it "product expect to count 4 related products when have more than 4" do
        expect(product.related_products.count).to eq Constants::DISPLAY_RELATED_PRODUCTS_MAX_COUNT
      end
    end

    context "when have 3 related products" do
      let!(:related_products) do
        create_list(:product, Constants::DISPLAY_RELATED_PRODUCTS_MAX_COUNT - 1, taxons: [taxon])
      end

      it "product expect to count 3 related products" do
        expect(product.related_products.count).
          to eq Constants::DISPLAY_RELATED_PRODUCTS_MAX_COUNT - 1
      end
    end

    context "when exist not related products" do
      it "product do not expect to match self and not related product" do
        expect(product.related_products).not_to include(product, not_related_product)
      end
    end
  end
end
