require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end
  it 'display all snacks asssociated with machine along with price' do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")
    snack_1 = Snack.create!(name: "Cheetos", price: 2.50)
    snack_2 = Snack.create!(name: "Doritos", price: 3.50)
    snack_3 = Snack.create!(name: "Fritos", price: 4.50)
    MachineSnack.create!(machine: dons, snack: snack_1)
    MachineSnack.create!(machine: dons, snack: snack_2)

    visit machine_path(dons)

    within "#snacks" do
      expect(page).to have_content(snack_1.name)
      expect(page).to have_content(snack_2.name)
      expect(page).to_not have_content(snack_3.name)
      expect(page).to have_content(snack_1.price)
      expect(page).to have_content(snack_2.price)
      expect(page).to_not have_content(snack_3.price)
    end
  end

  it 'display average price for all snacks in machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    machine2 = owner.machines.create(location: "Jeff's Mixed Drinks")
    snack_1 = Snack.create(name: "Cheetos", price: 2.50)
    snack_2 = Snack.create(name: "Doritos", price: 3.50)
    snack_3 = Snack.create(name: "Fritos", price: 4.50)
    MachineSnack.create(machine: dons, snack: snack_1)
    MachineSnack.create(machine: dons, snack: snack_2)
    MachineSnack.create(machine: machine2, snack: snack_3)

    visit machine_path(dons)

    within "#average_price" do
      expect(page).to have_content(dons.average_price)
      expect(page).to_not have_content(machine2.average_price)
    end
  end

  it 'display a form to add a snack to that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    machine2 = owner.machines.create(location: "Jeff's Mixed Drinks")
    snack_1 = Snack.create(name: "Cheetos", price: 2.50)
    snack_2 = Snack.create(name: "Doritos", price: 3.50)
    snack_3 = Snack.create(name: "Fritos", price: 4.50)
    snack_4 = Snack.create(name: "Fruit Rollups", price: 5.50)
    MachineSnack.create(machine: dons, snack: snack_1)
    MachineSnack.create(machine: dons, snack: snack_2)

    visit machine_path(dons)

    expect(page).to_not have_content(snack_3.name)
    expect(page).to have_content("Add a Snack")

    fill_in "Snack ID", with: "#{snack_3.id}"
    click_button "Submit"

    expect(current_path).to eq(machine_path(dons))

    within "#snacks" do
      expect(page).to have_content(snack_3.name)
      expect(page).to have_content(snack_3.price)
      expect(page).to_not have_content(snack_4.name)
    end
  end
end
