# Tournamentee

App to menage tournaments

## Stack

- Ruby 2.5.3
- Rails 6.0.2
- MySQL 5.7

gems beyond defaults:

- Bootstrap 4.0
- HAML 2.0
- RSpec 3.9
- FactoryBot

## setup

Run:
```
bin/setup
```

Task assumes You have MySQL configured. Remember to fill/modify environment variables

## Play with the app

there are two ways you can play with the app

#### automatic

Run:
```
rails db:seed
```

You can configure this task as you wish in `db/seeds.rb` file

#### manual

1. Run the server
2. create 16 teams, providing only their names
3. create tournament with previous 16 teams
4. generate results for every round
