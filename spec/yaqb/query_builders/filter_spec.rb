# frozen_string_literal: true

RSpec.describe Yaqb::QueryBuilders::Filter do
  let(:recipe1) { create(:recipe, title: 'Pasta Carbonara') }
  let(:recipe2) { create(:recipe, title: 'Tuna Sashimi') }
  let(:recipe3) { create(:recipe, title: 'French Toast') }
  let(:recipes) { [recipe1, recipe2, recipe3] }
  let(:scope) { Recipe.all }
  let(:params) { {} }
  let(:presenter) { RecipePresenter }
  let(:filter) { Yaqb::QueryBuilders::Filter.new(scope, params, presenter) }
  let(:filtered) { filter.filter }

  before { recipes }

  describe '#filter' do
    context 'without any params' do
      it { expect(filtered).to eq scope }
    end

    context 'with valid params' do
      context 'with title_eq="French Toast"' do
        let(:params) { HashWithIndifferentAccess.new(q: { title_eq: 'French Toast' }) }

        it 'gets only "French Toast" back' do
          expect(filtered.first.id).to eq recipe3.id
          expect(filtered.size).to eq 1
        end
      end

      context 'with "title_cont=Sashimi"' do
        let(:params) { HashWithIndifferentAccess.new(q: { title_cont: 'Sashimi' }) }
        it 'gets only "Tuna Sashimi" back' do
          expect(filtered.first.id).to eq recipe2.id
          expect(filtered.size).to eq 1
        end
      end

      context 'with "title_notcont=Pasta"' do
        let(:params) { HashWithIndifferentAccess.new(q: { title_notcont: 'Pasta' }) }
        it 'gets only "Tuna Sashimi and French Toast" back' do
          expect(filtered.first.id).to eq recipe2.id
          expect(filtered.last.id).to eq recipe3.id
          expect(filtered.size).to eq 2
        end
      end

      context 'with "title_start=Tuna"' do
        let(:params) { HashWithIndifferentAccess.new(q: { title_start: 'Tuna' }) }
        it 'gets only "Tuna Sashimi" back' do
          expect(filtered.first.id).to eq recipe2.id
          expect(filtered.size).to eq 1
        end
      end

      context 'with "title_end=Carbonara"' do
        let(:params) { HashWithIndifferentAccess.new(q: { title_end: 'Carbonara' }) }
        it 'gets only "Pasta Carbonara" back' do
          expect(filtered.first.id).to eq recipe1.id
          expect(filtered.size).to eq 1
        end
      end

      context 'with "created_at_lt=2013-05-10"' do
        let(:recipe1) { create(:recipe, created_at: '2019-10-15') }
        let(:params) { HashWithIndifferentAccess.new(q: { created_at_lt: '2019-10-23' }) }
        it 'gets only the recipe with created_at before 2019-10-23' do
          expect(filtered.first.id).to eq recipe1.id
          expect(filtered.size).to eq 1
        end
      end

      context 'with "created_at_gt=2018-12-12"' do
        let(:recipe1) { create(:recipe, created_at: '2018-10-13') }
        let(:recipe2) { create(:recipe, created_at: '2019-02-14') }
        let(:recipe3) { create(:recipe, created_at: '2018-11-15') }
        let(:params) { HashWithIndifferentAccess.new(q: { created_at_gt: '2018-12-12' }) }
        it 'gets only the recipe with created_at after 2018-12-12' do
          expect(filtered.first.id).to eq recipe2.id
          expect(filtered.size).to eq 1
        end
      end
    end

    context 'with invalid parameters' do
      context 'with invalid column name "fid"' do
        let(:params) { HashWithIndifferentAccess.new(q: { fid: '1' }) }
        it 'raises a "QueryBuilderError" exception' do
          expect { filtered }.to raise_error(Yaqb::Errors::QueryBuilderError)
        end
      end

      context 'with invalid predicate "gtz"' do
        let(:params) { HashWithIndifferentAccess.new(q: { id_eeq: '1' }) }
        it "raises a 'QueryBuilderError' exception" do
          expect { filtered }.to raise_error(Yaqb::Errors::QueryBuilderError)
        end
      end
    end
  end
end
