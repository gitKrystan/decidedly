require 'rails_helper'

feature 'Adding Options to a Matrix:' do
  given(:test_matrix) { Matrix.new(name: 'Test Matrix') }

  background do
    @test_matrix = Matrix.create(name: test_matrix.name)
  end

  scenario 'Adds new options when all validated fields are entered' do
    visit matrix_path(@test_matrix)
    click_on 'new-option'
    fill_in 'Name', with: 'Test Option'
    click_button 'save-option'
    expect(page).to have_content('Test Option')
  end

  scenario 'Returns an error when a validated field is not entered' do
    visit new_matrix_option_path(@test_matrix)
    click_button 'save-option'
    expect(page).to have_content('errors')
  end
end
