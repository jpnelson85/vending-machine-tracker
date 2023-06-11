require "rails_helper"

RSpec.describe Machine, type: :model do
  describe "validations" do
    it { should validate_presence_of :location }
  end
    
  describe "relationships" do
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  it 'can show average snack price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    machine2 = owner.machines.create(location: "Jeff's Mixed Drinks")
    snack_1 = Snack.create(name: "Cheetos", price: 2.50)
    snack_2 = Snack.create(name: "Doritos", price: 3.50)
    snack_3 = Snack.create(name: "Fritos", price: 4.50)
    MachineSnack.create(machine: dons, snack: snack_1)
    MachineSnack.create(machine: dons, snack: snack_2)
    MachineSnack.create(machine: machine2, snack: snack_3)
    
    expect(dons.average_price).to eq(3.0)
    expect(machine2.average_price).to eq(4.50)
  end
end
