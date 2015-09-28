**DO NOT READ THIS FILE ON GITHUB, GUIDES ARE PUBLISHED ON http://guides.rubymentor.io.**

Building a Vending Machine and learning programming along the way
=================================================================

This guide covers:

  * Classes
  * Hashes
  * Arrays and Tuples
  * Class initializers
  * Instance Methods
  * Instance Variables
  * Local Variables
  * Interfaces
  * Encapsulation

--------------------------------------------------------------------------------

NOTE: I use foul language as comic relief in this guide. If you are easily offended by words, maybe save yourself the offense. It is meant for comic relief.

## A love affair with `Hash`

A `Hash` is a Ruby *primitive* or _built-in_ *data type*. It also happens to be a storage mechanism. Think of it like boxes of shit with labels. Labelling two boxes with the same label removes the usefulness of the label, the same is true in hashes.

A label for a `Hash` is a *key*. Hashes are *key value* _pairs_, meaning the are build from keys (labels) and values (the shit in your labeled boxes). The labels are unique, but the shit in the boxes doesn't have to be.

```ruby```
{ '001': 'Newcastle Brown Ale' }
```

## An Interface

An interface is simply an aggreed form of communication, like English. Two people who speak English can *interface* with each other just fine, even if one is from Northern Ireland and one is from California... That would be an example of a sloppy iterface.

A strict, good interface would be two people closely related in interests, location, and beliefs and experiences as they would not use disperate words like _clink_ to the Californian. Let's focus on this kind of interface.

## Building a Drink Vending Machine

The best example of an interface is the Vending Machine, since it is ubiquitous and perfectly illustrates the mechanism. Here is the narrative:

> You have a $1 bill in your pocket and you want a drink.
> 
> There is a vending machine in front of you and it sells Coca Cola for 80 cents and Newcastle Brown Ale for $1.20. You insert your $1 bill.
> 
> The vending machine makes some noise as it makes your bill vanish. You then scan the machine for signs of what it sells and how to buy that said shit.
> 
> What you see are two large buttons, one for Coca Cola, one for Newcastle Brown Ale. You push the Coca Cola button as you are a broke ass bitch and got nada but a dollah.
> 
> More noises can be heard from deep inside the mechanical if not tempermental device. After a moment you hear a resounding THUD and you reach in a small receptacle in the machine and retrieve your corn syrup poison drink.

That is what we shall build, in Ruby.

## The `Class`

Ruby is an _object oriented_ programming language, meaning we wrap data and methods inside of *objects*. Objects can be made from a `class` or a `module` in Ruby.

A `class` is the object creation mechanism of choice when you want to represent a _thing_. Since we are going to make a vending machine we will use the `class` construct to define it. A vending machine is indeed, a _thing_.

```ruby
class VendingMachine
end
```

## An Intializer

An initializer is used when we _create_ and _object_. Imagine we want to write some code that _uses_ our new `VendingMachine` class:

```ruby
VendingMachine.new
```

Here we used the `VendingMachine` class and immediately *called* the initializer `method` *new*. The *.* character is the _calling operator_ in this context.

Usually if we want to *call a method* on an object we use the same name, ie:

```ruby
VendingMachine.new.vend
```

Would match a method called *vend* on our object, but in the strange case of the initializer in Ruby, we _call_ *new* and that translates to the following method:

```ruby
class VendingMachine

  def initialize
  end
end
```

Notice we called _new_ and we got _initialize_. It is always like this for classes and is because you are creating a *new VendingMachine* in object-orientated-programmer-speak.

*Initializers* are for setting some initial state in the object you want to create. Maybe the object requires something to come to life, like a file path, or in our case, a list of items the machine should sell.

If we put those items directly inside our `class` then the class would become severely limited in it's ability to be customized, and you know, every one wants to customize shit.

## Instance Variables

Instance variables are the mechanism for storing *data* on the objects. This is known as *state*. Objects have their own internal state. When *arguments* are passed to an *initializer* then they are typically set as *instance variables*:

```ruby
class VendingMachine

  def initialize(items)
    @items = items
  end
end
```

The value came in as `items` and we *assigned* an *instance variable* called `@items` to those items. It is an *instance variable* because of the designating *@* character. Instance variables are said to *persist* meaning they stick around, and *instance methods* in the same object can access their values:


```ruby
class VendingMachine

  def initialize(items)
    @items = items
  end

  def instance_method
    "I haz #{@items}!"
  end
end

VendingMachine.new("I am some argument to pass like wind").instance_method
=> I haz I am some argument to pass like wind!

INFO: => is a character meaning Ruby returned from the previous command you gave it and the value is displayed after that => thingy
```

## Back to that `Hash` business

`@items` needs to be some kind of valid list of items the `VendingMachine` should vend. Let's create the *data store* using a Hash. Hashes have to have a unique key and so we are using keys that could be found on a number pad.

```ruby
items = {
  '001': 'Cocoa Cola',
  '002': 'Newcastle Brown Ale'
}
```

We can now more sensibly construct our customizable object like so:

```ruby
VendingMachine.new( {{ '001' => 'Cocoa Cola' }, { '002' => 'Newcastle Brown Ale' }} )
```

Now those items are in only the vending machine instance returned by the `VendingMachine.new` call. We could now make a different one that also sells deez nuts, because beer without nuts....

```ruby
VendingMachine.new({
  '001' => 'Cocoa Cola', 
  '002' => 'Newcastle Brown Ale',
  '003' => 'Deez Nuts'
})
```

AD:

## An `attr_reader`

Are you ready to meet your first *macro*? Because here it be, the `attr_reader`.

By macro I mean this is *code that writes code*, but don't worry, it ain't no Terminator shit. Rather than ramble, behold! code:

```ruby
class VendingMachine
  # initializer hidden for brevity
  attr_reader :items
end

class VendingMachine
  # initializer hidden for brevity
  def items
    @items
  end
end
```

These two classes have identical functionality. The `attr_reader` actually is a *macro* for the second example. When you use `attr_reader` what you get is the method `items` that just exposes the value at the *instance variable* `@items`.

## Encapsulation

However, exposing the items that were sent in via the initializer makes little sense when you consider encapsulation, one of the founding principles of Object Oriented Programming or OOP herewhence.

So I am going to leave the `attr_reader` but I am going to *encapsulate* it inside my object so it is not in view of the public. To do so I will use the class level modifier `private`.

```ruby
class VendingMachine

  def initialize(items)
    @items = items
  end

private

  attr_reader :items
end
```

Why even put the reader in if I am only going to then hide it? Isn't that a bit dickteasish? The long and short of that would be, no. It is indeed useful, because I am a lazy bastard and constantly typing *@* all the time is tiring. So by leaving this `attr_reader` in our class but making it private means our class can refer to `@items` through a method call `items` which isn't just about saving teh single character. It is about making all the the internal and external communication interface, *normalized* which just means _fuck the snowflakes_.

In the words of Chuck:

> You are not special. You're not a beautiful and unique snowflake. You're the same decaying organic matter as everything else. We're all part of the same compost heap. We're all singing, all dancing crap of the world.

Yeah, fuck those snowflake mother fuckers!

## An Instance Method

It is time to be useful! Let's start making this shit do shit! We want our beer gawddammit. And we want it now!

```ruby
class VendingMachine
  # initializer hidden for brevity

  def vend(code, paid)
  end
end
```

Now we will create a machine using some items and set it to a *local variable* so we have a _reference_ to that created object. This allows us to create another vending machine and assign it to a different *local variable* so we have access to both.

```ruby
machine = VendingMachine.new({
  '001' => 'Cocoa Cola', 
  '002' => 'Newcastle Brown Ale',
  '003' => 'Deez Nuts'
}
machine.vend('001', 100)
```

Nothing will happen yet for two reasons, one is our Hash doesn't know shit about a price, which we will need, and two, because the method I wrote has jack in it. If there is nothing in it, Ruby will return `nil`. In Ruby, _everything_ returns the last expression, usually the last line of the method.

First let's add price to the Hash, which will require us to restructure it, also I am going to break it out of the method call into it's own *local variable*, *items*.

```ruby
items = {
  '001' => { name: 'Cocoa Cola',          price: 80  },
  '002' => { name: 'Newcastle Brown Ale', price: 120 },
  '003' => { name: 'Deez Nuts',           price: 80  }
}
```

Notice we added an inner hash where the value used to just be a string, the name. Now name is inside of another Hash. And we added price as well. So you can read this as so:

The hash with the *key* of '001' has a *value* of another Hash and that one has a *key* called _name_ that has the *value* of _'Cocoa Cola'_ and a _price_ that has the *value* of 80 cents. Simple!

Now we can deal with method arguments in this instance method...

## Method Arguments

Our instance method, `vend` takes two *arguments*, _code_ and _paid_. Between the method and it's arguments you have now described, in code, what will happen when someone puts in some money and presses some buttons!

## Back to the method of madness

The `vend` method is called like so:

```ruby
#items left out for brevity
VendingMachine.new(items).vend('001', 100')
```

The scenario is they put in $1 and then pressed 0 - 0 - 1. Now they are expecting their coke, but we didn't deliver it! The method is empty! Let's fix this before anyone else puts money in!

This is what the 'interface' looks like:

```ruby
items = {
  '001' => { name: 'Cocoa Cola',          price: 80  },
  '002' => { name: 'Newcastle Brown Ale', price: 120 },
  '003' => { name: 'Deez Nuts',           price: 80  }
}

v = VendingMachine.new(items)
v.vend('001', 100)
```

Now the code:

```ruby
def vend(code, paid)
  items[code.to_sym]
end
```

What I am doing here is passing the code (as a symbol) into the items hash, which is going to then use the code as the *key*. If they key is found the *value* of that key is returned, if it is not found, then *nil* is returned.

Now when we run the code we get the following behavior:

```ruby
v.vend('001', 100)
=> {:name=>"Cocoa Cola", :price=>80}
```

So it returns the hash we wanted, but it didn't give the person their change! Call a nerd!

## An Array and a Tuple

An `Array` just is a list of values... [1, 2, 3, 4, 5], ["tom", "dick", "harriet"].

Simple right? There are no keys, just values. This is what this method return... an `Array`, but WAIT THERE IS MORE!!

The `Array` we are going to return is a *Tuple*, which is a fancy way of saying this is an `Array`, but it is _ordered_ meaning the index of each item in the list has meaning. If you sorted a tuple, you ruin the ability to make sense of it.

But enough mouthing... This is what it _should_ return:

```ruby
v.vend('001', 100)
=> ["Cocoa Cola", 20]
```

This represents that they get their Coke and also they get their cambio. We could have expressed it in a hash, but I think I said before I am a lazy bastard; if I can get away with a tuple, I will do it. I like tuples. I love the word. I love the simplicity. I am a tuplehead.

So how do we go from this hash return:

```ruby
{:name=>"Cocoa Cola", :price=>80}
```

And instead get our tuple?

```ruby
["Cocoa Cola", 20]
```

Oh the fucking agony of it all!

But seriously, it isn't that hard because we are using Ruby. Ruby is great for lazy bastards like myself!

I have been omitting code left and right for brevity, but now I will give you what we have as a whole:

```ruby
class VendingMachine
  def initialize(items)
    @items = items
  end

  def vend(code, paid)
    item   = items[code.to_sym]
    change = paid - item[:price].to_i

    [item[:name], change]
  end

private

  attr_reader :items
end
```

The method `vend` now sets a *local variable* to an _item_ which is the hash it returned before. The next line creates a *local variable* and calculates the change deserved.

The last line of the method creates a new `Array`, our *tuple* with the _item name_ and the _change_. Pretty straight-forward right? Well, sort of, but what if they put in less than the correct amount?

Let's try that:

```ruby
items = { '001' => { name: 'Cocoa Cola', price: 80' } }
v = VendingMachine.new(items)
v.vend('001', 0)
=> ["Cocoa Cola", -80]
```

## Meet the *conditional*, `if`

We obviously don't want to vend anything if they didn't pay enough. So let's take the easy way out and add some *conditional logic* to the vend method. We will only return the item if they paid enough:

```ruby
  def vend(code, paid)
    item   = items[code.to_sym]
    change = paid - item[:price].to_i

    if paid >= item[:price].to_i
      [item[:name], change]
    else
      [nil, paid, paid - item[:price].to_i]
    end
  end
```

`if` the _paid_ variable is greater than or equal to the item price we vend and change, but if not, we send a tuple of 3 values, a nil for the item that wasn't paid for, a full refund, and a price difference to let them know how much more they need to depsit to get their item.

Let's try it out, let's pay 10 cents and expect a Coke:

```ruby
items = { '001' => { name: 'Cocoa Cola', price: 80' } }
v = VendingMachine.new(items)
v.vend('001', 10)
=> [nil, 10, -70]
```

## Transactions logs rock

As you can see, if we try to pay and we don't use enough money we are not vended the drink and we are refunded. If we send in enough money we are vended the drink and the change.

But the money that we were charged just goes into the void, which is not what the owner of said vending machine would want. We could add an *instance variable* like `@bank` and increment it when shit be vended, BUT there is a better way!

Instead of *mutating* a value with some increment, we will instead create a *transaction log* of monies made and change made; another *tuple*. It looks like this:

```ruby
class VendingMachine

  def initialize(items)
    @items = items
    @transactions = [] # We add an empty `Array` to store the transactions
  end

  def vend(code, paid)
    item   = items[code.to_sym]
    change = paid - item[:price].to_i
    if change >= 0
      # Here we add the current successful vend to the
      # transaction log
      @transactions << [ item[:price].to_i, change ]
      [item[:name], change]
    else
      [nil, paid, change]
    end
  end

private

  attr_reader :items
end
```

Now that we are recording these transactions we can create another *instance method* that will return the amount of money the machine has, based on that transaction log. To be extra thorough and shit we will also add a method to calculate the amount of change made.

## Methods vs Functions

Here is a great example to show the difference between functions and methods. Methods tend to _do stuff_ while Functions are just _calculations_. Functions should not change any object state, they take some values as arguments, do some calculation, and then return that calculated value.

Functions are awesome, I am highly suspicious of most Methods...

``` ruby
class VendingMachine

  ...

  def profit
    @transactions.reduce(0) {|acc, t| acc + t[0] }
  end

  def changed
    @transactions.reduce(0) {|acc, t| acc + t[1] }
  end

  ...
end
```

And to test it out we can start up irb and load the file like so:

```bash
irb -I"." -rfilename
```

And then simulate some vends:

```ruby
items = { '001' => { name: 'Beer', price: 80 }, '002' => { name: 'Coke', price: 50 } }
v = VendingMachine.new(items)
5.times { v.vend( '001', 100 ) }

v.income
=> 400

v.changed
=> 100
```

Pretty simple so far? Does your head hurt yet? Grab your lightsaber and head to the next section! (not written yet, use the force)

