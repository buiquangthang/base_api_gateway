# frozen_string_literal: true

# NOTE: we can apply the template of Model RSpec in this link
# https://gist.github.com/buiquangthang/8017c7a29174e7b396d20239be55f2a3

RSpec.describe Service do
  let(:service) { build(:service) }

  it 'has a valid factory' do
    expect(build(:service)).to be_valid
  end

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(service).to have_many(:routes) }

    # Databse columns/indexes
    it { expect(service).to have_db_column(:name).of_type(:string) }
    it { expect(service).to have_db_column(:url).of_type(:string) }
    it { expect(service).to have_db_column(:token).of_type(:string) }
  end
end
