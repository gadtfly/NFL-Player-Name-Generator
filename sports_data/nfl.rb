require 'httparty'

module SportsData
  class NFL
    include HTTParty
    base_uri 'api.sportsdatallc.org/nfl-t1'

    def initialize(key)
      @auth = {query: {api_key: key}}
    end

    def hierarchy
      self.class.get("/teams/hierarchy.json", @auth)
    end

    def roster(team_id)
      self.class.get("/teams/#{team_id}/roster.json", @auth)
    end

    # Fuck, I should really learn lenses
    def all_team_ids
      self.hierarchy['conferences'].flat_map do |conference|
        conference['divisions'].flat_map do |division|
          division['teams'].flat_map do |team|
            team['id']
          end
        end
      end
    end

    def all_player_names
      all_team_ids.flat_map do |team_id|
        sleep(1)  # Gotta be a more robust solution to client rate-limiting than this
        self.roster(team_id)['players'].flat_map do |player|
          player['name_full']
        end
      end
    end
  end
end
