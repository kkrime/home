# Introduction

The goal of this assignment is to test your familiarity with Go, or
provide a small project to start getting into it.

Requirements:

- A Go project, described below, using go modules for any dependencies
- Using any libraries of your choice, except for the poker logic. Please justify
  your choices on the `README.md` :)
- It should follow best practices
- It should run via `docker`

We expect you to return a `.zip` file with:

- All source files needed to run your project, including a `Dockerfile`
- A `README.md` markdown file with instructions on how to build and run your
  project, with and without `docker`, and any comments you might want to add

# Background

> Drip...

Ugh...

> ...drip...

Came on...

> ...drip...

*LARVIS*, did you seal the water tank properly?

> Of course I did, I know how important it is for you to keep our water
> reserves, human.

> ...drip...

*LARVISSSS*!!!! Ok fine, you go to the tank seal and press the lever a bit
more securely. Dripping seems to stop.

> Water seal closed at 105%

*LARVIS*, recalibrate water seal, this is the 100% now...

> Water seal recalibration... Done.

Well, at least *LARVIS* has stopped imitating the speech of cat video
commenters, like the last time it "learned" from the media database, so you take
this as progress. However, you are still incredibly bored in this station, even
when nothing is threatening to kill you.

You need a break from consuming Earth's early internet media on your ample free
time, and no more chess with *LARVIS*, it wasn't ever fun anyway, so... What
about Poker?

*LARVIS*, do you play poker?

> I'm sorry human, I know what it is from my knowledge database, but Space
> Command added a limitation to play it for some reason. Something about
> "gambling" and "bad idea in an isolated space station"

Right. Well, that doesn't apply when I'm alone here and getting nuts. You better
learn to play it, lets have a poker night!

> I'm sorry, I can't learn it on my own due to the limit in my programming. You
> could perhaps add it as an extension module?

Yesss!!! That would do. You remember you can program *LARVIS* to do pretty
much whatever, provided you add the module yourself. Poker night time!!!

# Program a Poker LARVIS module

One of the issues of having to do this yourself is that you don't really
remember all the Poker rules, so a simplified version will have to do. You write
down the rules you remember:

Cards:

- Each player gets a hand of 5 cards
- Available symbols are `23456789TJQKA`, in order of value (`A` being the more
  valuable)

Combinations in order of value:

- Four of a kind, like `77377`
- Full house, means 3 of a kind, and 2 of a kind, in the same hand, like `KK2K2`
- Triple, like `32666`
- Two pairs, like `77332`
- A pair, like `43K9K`
- High card, when there's none of the above, like `297QJ`

When two hands have the same combination value, the combination with the higher
cards wins. When there are two pairs, the higher pair is compared first, so
`99662` wins against `88776`. When comparing full houses, triples go first, then
pairs, so `88822` defeats `QQ777`. If the combinations are identical, then the
other cards are compared, highest to lowest, so `7T2T6` wins against `TT753`,
because `TT = TT`, `7 = 7`, but `6 > 5`.

With these rules in mind, you write a quick command line program to pass two
hands and output which one is the winner, the first or the second one. From
there, *LARVIS* should be able to evaluate hands and you would get your poker
night!

# Dockerize your LARVIS module

Huh, you just remembered, in order for *LARVIS* to load your little program, you
have to provide it with a `docker` image, so you quickly write a `Dockerfile`
and build it. Good to go!

# Appendix: Hand examples

Some examples of hands and what the result should be.

| Hand 1 | Hand 2 | Winner |
| :-----: |:-------:| :--:|
| `AAAQQ` | `QQAAA` | Tie |
| `53QQ2` | `Q53Q2` | Tie |
| `53888` | `88385` | Tie |
| `QQAAA` | `AAAQQ` | Tie |
| `Q53Q2` | `53QQ2` | Tie |
| `88385` | `53888` | Tie |
| `AAAQQ` | `QQQAA` | Hand 1 |
| `Q53Q4` | `53QQ2` | Hand 1 |
| `53888` | `88375` | Hand 1 |
| `33337` | `QQAAA` | Hand 1 |
| `22333` | `AAA58` | Hand 1 |
| `33389` | `AAKK4` | Hand 1 |
| `44223` | `AA892` | Hand 1 |
| `22456` | `AKQJT` | Hand 1 |
| `99977` | `77799` | Hand 1 |
| `99922` | `88866` | Hand 1 |
| `9922A` | `9922K` | Hand 1 |
| `99975` | `99965` | Hand 1 |
| `99975` | `99974` | Hand 1 |
| `99752` | `99652` | Hand 1 |
| `99752` | `99742` | Hand 1 |
| `99753` | `99752` | Hand 1 |
| `88822` | `QQ777` | Hand 1 |
| `99662` | `88776` | Hand 1 |
| `QQQAA` | `AAAQQ` | Hand 2 |
| `53QQ2` | `Q53Q4` | Hand 2 |
| `88375` | `53888` | Hand 2 |
| `QQAAA` | `33337` | Hand 2 |
| `AAA58` | `22333` | Hand 2 |
| `AAKK4` | `33389` | Hand 2 |
| `AA892` | `44223` | Hand 2 |
| `AKQJT` | `22456` | Hand 2 |
| `77799` | `99977` | Hand 2 |
| `88866` | `99922` | Hand 2 |
| `9922K` | `9922A` | Hand 2 |
| `99965` | `99975` | Hand 2 |
| `99974` | `99975` | Hand 2 |
| `99652` | `99752` | Hand 2 |
| `99742` | `99752` | Hand 2 |
| `99752` | `99753` | Hand 2 |
