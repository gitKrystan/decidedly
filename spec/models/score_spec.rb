require 'rails_helper'

RSpec.describe Score, type: :model do
  it { should belong_to :option }
  it { should belong_to :criterium }
  it { should belong_to :option }
  it { should validate_presence_of :amount }
  it { should validate_numericality_of(:amount).only_integer }
  it { should validate_presence_of :criterium }
  it { should validate_presence_of :option }
end