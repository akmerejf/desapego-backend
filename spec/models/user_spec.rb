require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  # it { is_expected.to have_many :items }
  # it { is_expected.to validate_presence_of(:name) }
end
