# frozen_string_literal: true

RSpec.describe Yaqb::QueryBuilders::Paginate do
  let(:recipe1) { create(:recipe) }
  let(:recipe2) { create(:recipe) }
  let(:recipe3) { create(:recipe) }
  let(:recipes) { [recipe1, recipe2, recipe3] }
  let(:scope) { Recipe.all }
  let(:params) { HashWithIndifferentAccess.new(page: '1', per: '2') }
  let(:url) { 'http://www.example.com/v1/recipes' }
  let(:paginate) { Yaqb::QueryBuilders::Paginate.new(scope, params, url) }
  let(:paginated) { paginate.paginate }

  before { recipes }

  describe '#paginate' do
    it { expect(paginated.size).to eq 2 }
    it { expect(paginated.first).to eq recipe1 }
    it { expect(paginated.last).to eq recipe2 }

    context "with invalid parameters" do
      let(:params) { HashWithIndifferentAccess.new(page: 'fake', per: '2') }
      it 'raises a QueryBuilderError exception' do
        expect { paginated }.to raise_error(Yaqb::Errors::QueryBuilderError)
      end
    end
  end

  describe '#links' do
    let(:links) { paginate.links }

    context 'when first page' do
      it { expect(links).to include(next: "#{url}?page=2&per=2") }
      it { expect(links).to include(last: "#{url}?page=2&per=2") }
    end

    context 'when last page' do
      let(:params) { HashWithIndifferentAccess.new(page: '2', per: '2') }
      it { expect(links).to include(first: "#{url}?page=1&per=2") }
      it { expect(links).to include(prev: "#{url}?page=1&per=2") }
    end
  end
end
