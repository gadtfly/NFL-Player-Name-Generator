# NFL-Player-Name-Generator
A Markov-ey thing that I haven't taken very far.

Supply a `secrets.rb` like:

```ruby
module Secrets
  module SportsData
    module NFL
      KEY = # http://developer.sportsdatallc.com/member/register
    end
  end
end
```

Run once:

```ruby
rake grab_all_player_names
```

Then, arbitrarily many times:

```ruby
rake generate_player_name
```

----

TODO:
* Clarify naming (or replace with suitably general and mathematically-correct libraries... AKA, redo in Haskell)
* Generalize markov-ey process to higher orders
* Experiment with other models for more interesting names
