require_relative 'secrets'
require_relative 'sports_data/nfl'
require_relative 'name_generator'

task :grab_all_player_names do
  File.open('playernames', 'w') do |f|
    f.puts(SportsData::NFL.new(Secrets::SportsData::NFL::KEY).all_player_names)
  end
end

task :generate_player_name do
  puts NameGenerator.new(open('playernames').read).name
end
