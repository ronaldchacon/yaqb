# frozen_string_literal: true

RSpec.describe Yaqb::QueryBuilders::Sort do
  let(:recipe1) { create(:recipe) }
  let(:recipe2) { create(:recipe) }
  let(:recipe3) { create(:recipe) }
  let(:recipes) { [recipe1, recipe2, recipe3] }
  let(:scope) { Recipe.all }
  let(:params) { HashWithIndifferentAccess.new(sort: 'id', dir: 'desc') }
  let(:presenter) { RecipePresenter }
  let(:sort) { Yaqb::QueryBuilders::Sort.new(scope, params, presenter) }
  let(:sorted) { sort.sort }

  before { recipes }

  describe '#sort' do
    context 'without any params' do
      let(:params) { {} }

      it { expect(sorted).to eq scope }
    end

    context 'with valid params' do
      it "sorts the collection by 'id desc'" do
        expect(sorted.first.id).to eq recipe3.id
        expect(sorted.last.id).to eq recipe1.id
      end
    end

    context "with invalid parameters" do
      let(:params) { HashWithIndifferentAccess.new({ sort: "fid", dir: "desc" }) }
      it 'raises a QueryBuilderError exception' do
        expect { sorted }.to raise_error(Yaqb::Errors::QueryBuilderError)
      end
    end
  end
end
