require 'rails_helper'

feature 'Adding Criteria to a Matrix:' do
  given(:test_matrix) { Matrix.new(name: 'Test Matrix') }

  background do
    @test_matrix = Matrix.create(name: test_matrix.name)
  end

  scenario 'Adds new criteria when all validated fields are entered' do
    visit matrix_path(@test_matrix)
    click_on 'new-criterium'
    fill_in 'Name', with: 'Test Criterium'
    click_button 'save-criterium'
    expect(page).to have_content('Test Criterium')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit new_matrix_criterium_path(@test_matrix)
    click_button 'save-criterium'
    expect(page).to have_content('errors')
  end
end
