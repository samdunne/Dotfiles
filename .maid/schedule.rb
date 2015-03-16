require 'whenever'

every 30.minutes do
  command "maid clean -f --silent > /dev/null 2>&1"
end

every 24.hours do
  command "maid clean -f --silent --rules=~/.maid/daily.rb > /dev/null 2>&1"
end
