# frozen_string_literal: true

require_relative 'app'

describe 'Savoir si il y a une valeur dans le tableau' do
  it 'should return false if the array is not empty ' do
    expect(to_hhash(scrap_name(Page), scrap_value(Page)).length).to be > 10
  end
end
