Maid.rules do

  rule 'Update homebrew' do
    `brew update`
  end

  rule 'Update Macbook' do
    `brew upgrade`
  end

  rule 'Cleanup homebrew' do
    `brew cleanup`
  end

end