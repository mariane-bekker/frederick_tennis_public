```text
  ___             _   ___                _
 | __>_ _  ___  _| | |_ _|___ ._ _ ._ _ <_> ___
 | _>| '_>/ ._>/ . |  | |/ ._>| ' || ' || |<_-<
 |_| |_|  \___.\___|  |_|\___.|_|_||_|_||_|/__/
```
Use the included controller and model to create a simple API for scoring games
of tennis. 

## Scoring in tennis

Scoring in tennis is a little more complicated than other games. The following
is a summary of the way to score tennis games, but the definitive guide can be
found at the [United States Tennis
Association](https://www.usta.com/en/home/improve/tips-and-instruction/national/tennis-101--scoring.html)
website.

Two players competing against one another in tennis is referred to as a
"match", where a match consists of a series of tennis _sets_, each of which is
comprised of a series of games. A tennis game consists of a series of _points_
played with the same player serving the ball each time. You have been given the
task of building a minimally viable product to score tennis, which will just be
an API endpoint to score a single game. 

A game begins with both players at zero points. When the game is in this state,
the score is called out as "love all". "Love" is zero points, and the score is
followed by "all" when the score for both players is the same. The exception is
when both players in a game have scored 3 points, making the score 40-40 which
is called "deuce". From that point on, any tied score will be called "deuce"
regardless of the amount of points scored. Once a player reaches 40 (3 points
scored), they must score two more points than their opponent to win the game.

The following are all scores where the player serving the ball has won:

  * 40-15
  * 40-0
  * 40-40 then tiebreak 2-0

Once a deuce is reached, the score is tied and the tie must be broken by
continuing to play. If, during this time, a player scores, that player is
said to have the "advantage". If the player with the advantage is the
player who serves during the game, the score is then called "Advantage in";
when it's the opposing player, this is called "Advantage out". Here are some
post-deuce scores and their calls:

  * 1-0: "Advantage in"
  * 2-3: "Advantage out"
  * 1-1: "Deuce"
  * 5-4: "Advantage in"

If the player with the advantage wins another point, they win because their
score is now 2 points higher than their opponent. If the player without the
advantage wins a point, the score is again "deuce" since it's tied. A deuce is
called a deuce regardless of if it's 3-3 or 389-389; any tie is a deuce.

## The API

Build a simple API for keeping track of a tennis set. A partially-built
Ruby on Rails app has been provided for you to add to. Your API must have
endpoints for matches and games. Sets are called TennisSets to avoid
colliding with the name Set in Ruby.

### `/games` endpoint

`POST /games` -- Data can be POSTed to this endpoint to create a game.

Games accept a JSON payload like this:
```javascript
{
  "server": "Mick Jagger",
  "receiver": "David Bowie"
}
```

The above payload would start a game between Mick Jagger and David Bowie with
Mick Jagger serving the ball each point.

`GET /games` -- Gets all the games.

`GET /games/:id` -- Gets a specific game's score.

`POST /games/:id/score` -- Accepts a player's name and adds a point to their
score. The returned JSON payload should describe the score so far (see below).

### Game payload

Games contain the following attributes:

  * `server` - The player serving the ball during this game
  * `receiver` - The player receiving (i.e. not serving) the ball
  * `server_score` - The actual count of points the server has scored. For
    example if the server has won a point twice, this will be `2`, _not_ `30`.
  * `receiver_score` - See `server_score`
  * `called_score` - This is a string value representing what the tennis judge
    should call out for this score. (Examples below.)

Here are some examples of receiver/server scores and the corresponding called
scores:

  * 0-0 - "Love all"
  * 0-1 - "Love 15"
  * 2-2 - "30 all"
  * 3-0 - "40 love"
  * 4-1 - "Game Mick Jagger"
  * 12-12 - "Deuce"
  * 4-5 - "Advantage out"
  * 5-7 - "Game David Bowie"

Note that the server's score always comes first. Here is a full example of a
response payload:

```javascript
{
  "server": "Mick Jagger",
  "receiver": "David Bowie",
  "server_score": 3,
  "receiver_score": 2,
  "called_score": "40-30"
}
```
