# frozen_string_literal: true

require_relative 'cher_depute'

describe "Chercher l'email d'une mairie" do
  it 'Should return the email of a webpage' do
    expect(get_townhall_email(Page_avernes)).to eq('mairie.avernes@orange.fr')
  end
end

describe 'Creer un tableau de liens hypertexte' do
  it 'should return an array of a href' do
    expect(get_townhall_urls(Page_links).empty?).to be false
    expect(get_townhall_urls(Page_links).class).to eq Array
    expect(get_townhall_urls(Page_links)[1]).to be_a String
    expect(get_townhall_urls(Page_links)[1]).to include 'https'
  end
end