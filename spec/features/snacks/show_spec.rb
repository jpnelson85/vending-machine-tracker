require 'rails_helper'

RSpec.describe "When a user visits a snack show page", type: :feature do
  it 'displays name, price, and location of the snack, snack count, and average price for that location' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    jeffs  = owner.machines.create(location: "Jeff's Mixed Drinks")
    machine2 = owner.machines.create(location: "Jeff's Mixed Drinks")
    snack_1 = Snack.create(name: "Cheetos", price: 2.50)
    snack_2 = Snack.create(name: "Doritos", price: 3.50)
    snack_3 = Snack.create(name: "Fritos", price: 4.50)
    snack_4 = Snack.create(name: "Fruit Rollups", price: 5.50)
    MachineSnack.create(machine: dons, snack: snack_1)
    MachineSnack.create(machine: dons, snack: snack_2)

    visit snack_path(snack_1)

    expect(page).to have_content(snack_1.name)
    expect(page).to have_content("Price: $#{snack_1.price}")
    expect(page).to have_content("Locations:")
    expect(page).to have_content("#{dons.location} #{dons.snack_count} kinds of snacks, average price of $#{dons.average_price}")
    expect(page).to_not have_content(jeffs.location)
    expect(page).to_not have_content(snack_3.name)
    expect(page).to_not have_content(snack_4.name)
  end

end
    
    