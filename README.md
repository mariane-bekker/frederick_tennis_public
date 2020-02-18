```text
  ___             _   ___                _
 | __>_ _  ___  _| | |_ _|___ ._ _ ._ _ <_> ___
 | _>| '_>/ ._>/ . |  | |/ ._>| ' || ' || |<_-<
 |_| |_|  \___.\___|  |_|\___.|_|_||_|_||_|/__/
```
Use the included controller and model to create a simple API for scoring games
of tennis. 

## Scoring in tennis

Scoring in tennis is a little more complicated than other games, as the number
of points scored don't exactly match the score as its called in the game. A
player's score goes from 'love' to 15 to 30 to 40 as they score each point. If the
score is tied, that score is called with "all" afterwards; e.g. "15 all" or
"Love all". The following is a summary of the way to score tennis games, but
the definitive guide can be found at the [United States Tennis
Association](https://www.usta.com/en/home/improve/tips-and-instruction/national/tennis-101--scoring.html)
website.

The same player always serves the ball in a game of tennis, and the server's score comes
first when calling the score out. The word "love" is used to mean zero points,
so a player's score starts at "love", then if they get a point their score is
then 15, then after another point their score would be 30, and another one 40.
To win a game of tennis, a player must score four points _and_ score 2 more
points than their opponent. If the players both score 3 times and both their
scores are 40, this is called a "deuce". A deuce specifically describes the
situation where both players have scored at least 3 points and now have the
same number of points won.

If the two players are tied and one player gets a point, they are said to have
"advantage" because their next point would end the game. If the server is the
one with advantage, the score is called "Advantage in"; otherwise it is called
"Advantage out". If at this point the other non-advantaged player scores a
point, the score will again be a deuce.
If the advantaged player scores a point, ending the game, the score is called 'Game So-and-so' where 'So-and-so' is the name of the player who won the game
### Example

Let's imagine a game between Venus and Serena Williams.

  1. At the start of the game, neither player has scored any points, so the
     score is 0-0 or "Love all".
  2. Venus scores a point and now the score is "15 love".
  3. Serena scores a point and now the score is "15 all".
  4. Serena scores another point and now the score is "15 30".
  5. Serena scores again, making the score "15 40". At this point, if Serena
     scores one more point she will win, because she will have scored 4 or more
     points and will be at least 2 points ahead.
  6. Venus scores, making the score "30 40". Serena can still win with her next
     point.
  7. Venus scores again, tying the score at 40-40, called "Deuce".
  8. Serena scores a point, making the score "Advantage Serena".
  9. Serena's next point wins the game, as she will have scored at least 4
     points total, and will have scored 2 more than Venus.

## The API

Build a simple API for keeping track of a tennis game. A partially-built
Ruby on Rails app has been provided for you to add to.

### `/games` endpoint

`POST /games` -- Data can be POSTed to this endpoint to create a game.

Games accept a JSON payload like this:
```javascript
{
  "server": "Venus",
  "receiver": "Serena"
}
```

The above payload would start a game between Venus and Serena Williams with
Venus serving the ball each point.

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
  * 4-1 - "Game Venus"
  * 12-12 - "Deuce"
  * 4-5 - "Advantage out"
  * 5-7 - "Game Serena"

Note that the server's score always comes first. Here is a full example of a
response payload:

```javascript
{
  "server": "Venus",
  "receiver": "Serena",
  "server_score": 3,
  "receiver_score": 2,
  "called_score": "40 30"
}
```
