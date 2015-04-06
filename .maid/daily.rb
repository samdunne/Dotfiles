Maid.rules do

  if /darwin/ =~ RUBY_PLATFORM do
    rule 'Update homebrew/Macbook' do
      `update`
    end
  end

end
