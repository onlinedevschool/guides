**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://video.rubymentor.io.**

Building a Deck of Playing Cards in Ruby, the clean and easy way
=================================================================

In this guide you will learn how to:

  * Use IRB as an immediate feedback loop
  * Create symbol shortcut arrays
  * Use ```map``` to transform an array
  * Use ```flat_map``` to transform and flatten
  * Creating simple obects with `Struct`
  * Create `value` objects

--------------------------------------------------------------------------------

## REPL Driven Development

You have probably heard of Test Driven Development, well REPL Driven Development
is a good friend of TDD. Whereas Test Driven Development is there to drive the
design of the interface of your code, and then leave you with a suit of automated
tests, RDD is there to be in the front lines in figuring out what the hell you 
should be writing in the first place.

But wait! What the hell is `REPL`? Ok, ok, let me back up just a moment.

## What the hell is a REPL?

A REPL (there, I said it AGAIN without telling you what it is 😜 ) stands for

* Read
* Evaluate
* Print
* Loop

Imagine this, you are sitting at a card table. The Dealer pulls a card from
the top of the deck (Read), they then slide it to you (Evaluate), you read it
(Print), and then the game repeats (Loop).

NOTE: When you see ```$``` in grey sections, it  represents your 'prompt' and
you shouldn't copy or paste it into the Terminal

TIP: On OSX: press ```cmd-space``` and then start typing 'term' and hit enter when
you see it match the icon.

```bash
$ irb
```

You are now in said REPL. Let's start by creating an array of `RANKS` and we will
use the Ruby array shortcut to create `symbols`:


## Representing the RANKS

```ruby
RANKS = %i[ace two three four five six seven eight nine ten jack queen king]
```

We can see that a `CONSTANT` was created with the 13 symbol values we wanted.

NOTE: Throughout this lesson you should be entering the code into IRB. You aren't
creating any Ruby files today, instead we will just run everything in the REPL, IRB.

TIP: When a constant or a symbol is created, they are only created _once_ in
memory. You can re-create a symbol value over and over, but in memory, it is
always the same symbol. There can be only :one

Now that we have 13 `ranks` we need to represent the 4 `suits`:

## Representing the SUITS

```ruby
RANKS = %i[ace two three four five six seven eight nine ten jack queen king]
SUITS = %i[heart club diamond spade]
```

Now I will show you two excellent methods to operate over an array. One is ```map```
and another is ```flat_map```. They both work almost in the same manner, but
```flat_map``` additionally flattens one level of nesting.

## Arrays and map

A ```map``` is the process of starting with one collection of values, or an Array,
then `iterating` over that list, and for every item in the original list, a new
item will be created or transformed from the previous list. If you started with
an array with 100 elements and you ```map``` it, you end up with a `new` array
with 100 elements in it. An example:

```ruby
%w[bob jim sue janet tommy pat].map {|name| name.chars.count }

=> [3, 3, 3, 5, 5, 3]
```

When you run that you can see that it returned a _new_ array and instead of names
we got the character counts instead. If the name on the current iteration is Bob,
we end up with a 3 instead. You can also use map to transform the elements, ie:

```ruby
%w[bob jim sue janet tommy pat].map {|name| "#{name.capitalize} is awesome!" }

=> ["Bob is awesome!", "Jim is awesome!", "Sue is awesome!", "Janet is awesome!", "Tommy is awesome!", "Pat is awesome!"]
```

This time instead of returning the character count for the name, we capitalized the
first character, and then added "is awesome!" to the string. But let's get back to 
our _Playing Card_ example.

We will use our newly learned ```map``` method to generate 13 cards representing
their ranks:

```ruby
RANKS = %i[ace two three four five six seven eight nine ten jack queen king]
SUITS = %i[heart club diamond spade]

RANKS.map {|rank| Card.new(rank) }
```

## Using IRB to "test drive"

When you try and run that it is going to blow up. BOOM!

```ruby
RANKS.map {|rank| Card.new(rank) }

NameError: uninitialized constant Card
```

The REPL is telling us we need to define the `Card` object, so let's get that done
now. We will use a ```Struct``` which allows us to create a simple class that
automatically adds any attributes it is initialized with. Here we set `Card` 
to a new `Struct` and we tell `Struct` that it will have one attribute, ``:rank```.

```ruby
Card = Struct.new(:rank)

card = Card.new(:heart)
=> #<struct Card rank=:heart>

card.rank
=> :heart
```

##  Generating 52 cards

Wow, that was easy! The ```Struct``` is a powerful, simple construct. Now that we have
a `Card` object we can plug it into our code to create a deck:

```ruby
RANKS = %i[ace two three four five six seven eight nine ten jack queen king]
SUITS = %i[heart club diamond spade]

Card = Struct.new(:rank)
RANKS.map {|rank| Card.new(rank) }

=> [#<struct Card rank=:ace>, #<struct Card rank=:two>, #<struct Card rank=:three>, #<struct Card rank=:four>, #<struct Card rank=:five>, #<struct Card rank=:six>, #<struct Card rank=:seven>, #<struct Card rank=:eight>, #<struct Card rank=:nine>, #<struct Card rank=:ten>, #<struct Card rank=:jack>, #<struct Card rank=:queen>, #<struct Card rank=:king>]
```

How cool is that? We now have 13 cards and each has a rank A-2-K!

The last thing to do here is to represent the suits... REPRESENT! Sorry, couldn't resist.
I must have typing tourettes. We can implement those pesky `:suits` using another map, but
first we need to expand our ```struct``` to include the `suit`:

```ruby
Card = Struct.new(:rank, :suit)
RANKS.map {|rank| SUITS.map {|suit| Card.new(rank, suit) } }

=> [[#<struct Card rank=:ace, suit=:heart>, #<struct Card rank=:ace, suit=:club>, #<struct Card rank=:ace, suit=:diamond>, #<struct Card rank=:ace, suit=:spade>], [#<struct Card rank=:two, suit=:heart>, #<struct Card rank=:two, suit=:club>, #<struct Card rank=:two, suit=:diamond>, #<struct Card rank=:two, suit=:spade>], [#<struct Card rank=:three, suit=:heart>, #<struct Card rank=:three, suit=:club>, #<struct Card rank=:three, suit=:diamond>, #<struct Card rank=:three, suit=:spade>], [#<struct Card rank=:four, suit=:heart>, #<struct Card rank=:four, suit=:club>, #<struct Card rank=:four, suit=:diamond>, #<struct Card rank=:four, suit=:spade>], [#<struct Card rank=:five, suit=:heart>, #<struct Card rank=:five, suit=:club>, #<struct Card rank=:five, suit=:diamond>, #<struct Card rank=:five, suit=:spade>], [#<struct Card rank=:six, suit=:heart>, #<struct Card rank=:six, suit=:club>, #<struct Card rank=:six, suit=:diamond>, #<struct Card rank=:six, suit=:spade>], [#<struct Card rank=:seven, suit=:heart>, #<struct Card rank=:seven, suit=:club>, #<struct Card rank=:seven, suit=:diamond>, #<struct Card rank=:seven, suit=:spade>], [#<struct Card rank=:eight, suit=:heart>, #<struct Card rank=:eight, suit=:club>, #<struct Card rank=:eight, suit=:diamond>, #<struct Card rank=:eight, suit=:spade>], [#<struct Card rank=:nine, suit=:heart>, #<struct Card rank=:nine, suit=:club>, #<struct Card rank=:nine, suit=:diamond>, #<struct Card rank=:nine, suit=:spade>], [#<struct Card rank=:ten, suit=:heart>, #<struct Card rank=:ten, suit=:club>, #<struct Card rank=:ten, suit=:diamond>, #<struct Card rank=:ten, suit=:spade>], [#<struct Card rank=:jack, suit=:heart>, #<struct Card rank=:jack, suit=:club>, #<struct Card rank=:jack, suit=:diamond>, #<struct Card rank=:jack, suit=:spade>], [#<struct Card rank=:queen, suit=:heart>, #<struct Card rank=:queen, suit=:club>, #<struct Card rank=:queen, suit=:diamond>, #<struct Card rank=:queen, suit=:spade>], [#<struct Card rank=:king, suit=:heart>, #<struct Card rank=:king, suit=:club>, #<struct Card rank=:king, suit=:diamond>, #<struct Card rank=:king, suit=:spade>]]
```

## Matrices and flat_map

Almost! But you may have noticed this is divided into ranks and suits, meaning each set
of ranks for a suit are nested in an inside array and that is _not_ what we want! We
want a _single_ list of 52 cards. Not 4 sets of 13.

Now we *could* use ```flatten``` at the end of that return, but that is sloppy, and I am
just not into slop. Instead we will use the brother of ```map```, ```flat_map``` which
maps and collapses 1 level of nesting:

```ruby
RANKS.flat_map {|rank| SUITS.map {|suit| Card.new(rank, suit) } }

=> [#<struct Card rank=:ace, suit=:heart>, #<struct Card rank=:ace, suit=:club>, #<struct Card rank=:ace, suit=:diamond>, #<struct Card rank=:ace, suit=:spade>, #<struct Card rank=:two, suit=:heart>, #<struct Card rank=:two, suit=:club>, #<struct Card rank=:two, suit=:diamond>, #<struct Card rank=:two, suit=:spade>, #<struct Card rank=:three, suit=:heart>, #<struct Card rank=:three, suit=:club>, #<struct Card rank=:three, suit=:diamond>, #<struct Card rank=:three, suit=:spade>, #<struct Card rank=:four, suit=:heart>, #<struct Card rank=:four, suit=:club>, #<struct Card rank=:four, suit=:diamond>, #<struct Card rank=:four, suit=:spade>, #<struct Card rank=:five, suit=:heart>, #<struct Card rank=:five, suit=:club>, #<struct Card rank=:five, suit=:diamond>, #<struct Card rank=:five, suit=:spade>, #<struct Card rank=:six, suit=:heart>, #<struct Card rank=:six, suit=:club>, #<struct Card rank=:six, suit=:diamond>, #<struct Card rank=:six, suit=:spade>, #<struct Card rank=:seven, suit=:heart>, #<struct Card rank=:seven, suit=:club>, #<struct Card rank=:seven, suit=:diamond>, #<struct Card rank=:seven, suit=:spade>, #<struct Card rank=:eight, suit=:heart>, #<struct Card rank=:eight, suit=:club>, #<struct Card rank=:eight, suit=:diamond>, #<struct Card rank=:eight, suit=:spade>, #<struct Card rank=:nine, suit=:heart>, #<struct Card rank=:nine, suit=:club>, #<struct Card rank=:nine, suit=:diamond>, #<struct Card rank=:nine, suit=:spade>, #<struct Card rank=:ten, suit=:heart>, #<struct Card rank=:ten, suit=:club>, #<struct Card rank=:ten, suit=:diamond>, #<struct Card rank=:ten, suit=:spade>, #<struct Card rank=:jack, suit=:heart>, #<struct Card rank=:jack, suit=:club>, #<struct Card rank=:jack, suit=:diamond>, #<struct Card rank=:jack, suit=:spade>, #<struct Card rank=:queen, suit=:heart>, #<struct Card rank=:queen, suit=:club>, #<struct Card rank=:queen, suit=:diamond>, #<struct Card rank=:queen, suit=:spade>, #<struct Card rank=:king, suit=:heart>, #<struct Card rank=:king, suit=:club>, #<struct Card rank=:king, suit=:diamond>, #<struct Card rank=:king, suit=:spade>]
```

## Printing the card value

Now THAT is more like it! But are we done? Not really. If you have a single card there
should be some way to get a string like "Ace of Spades". We can do that by overriding
the built-in method ```to_s```. But _why_ override and use ```to_s```?

In Ruby, we use methods like ```to_s``` or ```to_i``` or ```to_a``` in order to use
one type as another, or in our world, to Duck-type it. Duck typing is a form of
`polymorphism` which really just means you can ride a horse or a motorcycle but a
horse isn't a motorcycle.

Essentially these methods are 'casting' methods that cast one type as another for the
sake of output. ie:

```ruby
nil.to_a
=> []

nil.to_s
=> ""

nil.to_i
=> 0
```

Since we want the `String` representation of a `Card`, it makes sense to just use the
```to_s``` method:

```ruby
Card = Struct.new(:rank, :suit) do
  def to_s
    "#{rank.capitalize} of #{suit.capitalize}s"
  end
end

Card.new(:ace, :heart).to_s

=> "Ace of Hearts"
```

## Make it a value object

You might think we are done, but yet once again, we are not. Welcome to the life as a
software developer. Just when you think you are done, you are totally _wrong_. I will
demonstrate what the hell I am babbling about:

```ruby
Card.new(:ace, :heart) == Card.new(:ace, :heart)

=> false
```

False? But any Ace of Hearts should be the same as any other Ace of Hearts! My friends,
you have stumbled on _object identity_ which means that two objects held in memory
are not always the same object. For instance:

```ruby
1 == 1

=> true

"1" == "1"

=> false
```

Why is ```1 == 1``` but ```"1" != "1"```? Every object in memory has it's own
`object_id` which is to say a unique identifier to determine when we are talking
about the same object with two references, or two references to two objects:

```ruby
1.object_id

=> 3

1.object_id == 1.object_id

=> true
```

This is what is known as a `vaue object` meaning that when we compare it against
another object we want to compare the _value_ not the _object_id_. In the case
of the number one they happen to be the same, but this is not always true. For
instance:

```ruby
"foo" == "foo"

=> true

"foo".object_id = 70151215874520
"foo".object_id = 70151215860640
```

WTF? "foo" is equal to "foo" but two different "foo"s have different object_ids?
Well, yes. Each time you typed "foo" you got a _new_ string. BUT, remember what I
said about `value objects`? We aren't going to compare the _object_id_ here, we
are going to compare the `value`, thus it is a `value object`.

Now let's make our ```Card``` a value object:

```ruby
Card = Struct.new(:rank, :suit) do
  def ==(other)
    self.rank == other.rank &&
      self.suit == other.suit
  end
end

Card.new(:ace, :heart) == Card.new(:ace, :heart)

=> true
```

BEHOLD! A `value object`!

## Shuffling the cards

We are *done*, *finally*! But WAIT JIM! You cry. We cannot shuffle this deck of
cards? Should I write my own ```shuffle``` method?

Absolutely not. You won't write an efficient shuffle anyway. It would be far
better to lean on Ruby to do this for you. Luckily we chose to implement this
collection of cards are an ```Array``` so we get to use methods from ```Array```
and ```Enumberable```, and one of those super duper awesomesauce methods is
```shuffle```!

```ruby
deck = RANKS.flat_map {|rank| SUITS.map {|suit| Card.new(rank, suit) } }
shuffled = deck.shuffle

=> [#<struct Card rank=:jack, suit=:diamond>, #<struct Card rank=:jack, suit=:club>, #<struct Card rank=:ace, suit=:spade>, #<struct Card rank=:six, suit=:heart>, #<struct Card rank=:ten, suit=:diamond>, #<struct Card rank=:six, suit=:diamond>, #<struct Card rank=:two, suit=:diamond>, #<struct Card rank=:eight, suit=:club>, #<struct Card rank=:seven, suit=:diamond>, #<struct Card rank=:two, suit=:heart>, #<struct Card rank=:three, suit=:club>, #<struct Card rank=:six, suit=:club>, #<struct Card rank=:queen, suit=:spade>, #<struct Card rank=:jack, suit=:heart>, #<struct Card rank=:two, suit=:club>, #<struct Card rank=:king, suit=:club>, #<struct Card rank=:four, suit=:club>, #<struct Card rank=:three, suit=:spade>, #<struct Card rank=:six, suit=:spade>, #<struct Card rank=:king, suit=:spade>, #<struct Card rank=:ten, suit=:heart>, #<struct Card rank=:king, suit=:diamond>, #<struct Card rank=:three, suit=:diamond>, #<struct Card rank=:king, suit=:heart>, #<struct Card rank=:four, suit=:heart>, #<struct Card rank=:queen, suit=:diamond>, #<struct Card rank=:eight, suit=:spade>, #<struct Card rank=:five, suit=:heart>, #<struct Card rank=:two, suit=:spade>, #<struct Card rank=:ten, suit=:spade>, #<struct Card rank=:four, suit=:diamond>, #<struct Card rank=:jack, suit=:spade>, #<struct Card rank=:nine, suit=:spade>, #<struct Card rank=:seven, suit=:club>, #<struct Card rank=:eight, suit=:heart>, #<struct Card rank=:ace, suit=:club>, #<struct Card rank=:eight, suit=:diamond>, #<struct Card rank=:ten, suit=:club>, #<struct Card rank=:seven, suit=:heart>, #<struct Card rank=:three, suit=:heart>, #<struct Card rank=:nine, suit=:heart>, #<struct Card rank=:four, suit=:spade>, #<struct Card rank=:nine, suit=:diamond>, #<struct Card rank=:nine, suit=:club>, #<struct Card rank=:ace, suit=:heart>, #<struct Card rank=:five, suit=:spade>, #<struct Card rank=:ace, suit=:diamond>, #<struct Card rank=:seven, suit=:spade>, #<struct Card rank=:queen, suit=:heart>, #<struct Card rank=:five, suit=:diamond>, #<struct Card rank=:five, suit=:club>, #<struct Card rank=:queen, suit=:club>]
```

WHEW! I probably could go on and on with more things to do here, but I think
this would make a great stopping point, and throwing too much shit at anything
besides a monkey (He threw first!) isn't wise. Come to think of it, throwing
shit at a creature strong enough to pull the ears off a Gundark isn't wise
either.

Adios.
