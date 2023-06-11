require 'rails_helper'

RSpec.describe Snack, type: :model do 
  it { should have_many :machine_snacks }
  it { should have_many(:machines).through(:machine_snacks)}
end