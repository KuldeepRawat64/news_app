# news_app

## This is a News app created with using bloc for state management and sqflite for managing the cache.

starting first with our stories block.

So the big, huge focus inside this entire application was having as efficient a data loading process

as possible.

Everything started here.

Inside of these stories block the stories.

Block got access to a copy of our repository, and that repository mediated access to the two different

information providers that we had inside of an application, the API provider and the database provider

as well inside the repository dart file.

So here's a repository.

We had a list of different sources and caches that the repository could use.

These sources and caches were defined using abstract classes.

So at the very bottom of the file we put together an idea of what you have to do to implement a source

and idea of what you have to do to implement a cache as well.

Now, these two interfaces that were created by these abstract classes right here were implemented by

the API provider and the database provider as well.

The very important thing to keep in mind about these two abstract classes or the use of interfaces in

general is that they only define the requirements for the names of methods, the arguments and the return

values as well.

There's nothing to say that the add item method or the clear method right here have to actually do something

in particular.

And so we absolutely can create a class that implements Vikash abstract class that has a incredibly

broken implementation of add item or clear.

It's really up to you to make sure that whatever class you create that's going to implement these abstract

classes actually implements these methods in a correct fashion.

The methods here are really just used for record keeping and not necessarily to validate what your code

truly does.

Now, inside the repository, the most important method, without a doubt, was fetch item right here,

whenever someone called fetch item, we looked through all of our different sources in a particular

order and waited for one to retrieve the item that we were looking for once we found that item.

We then looked through all the different caches and back the item up into those caches.

And then finally we return that item.

And so that brings us back to our Stories Block.

We expose the repository through the use of the top IDs and the items output and the items Fetcher streams,

remember that we had the items output and the items Fetcher stream comptrollers inside of here specifically

to solve that multi subscription issue that we ran into.

If you recall, we had found that the items transformer here was being called far more often than it

should have been called.

And that was all because every time we had a stream builder that listen to our at the time items stream,

every single stream builder created a new separate.

Scan stream transformer.

And so for every single string builder that we had, we saw that we just were getting these repetitive,

incredible number of calls to fetch the same items over and over again.

And so we solved that.

By setting up two separate stream controllers inside of our stories block, we had the items fetcher

and the items output, the fetcher was sort of a single subscription stream.

Now, behind the scenes, it still was a broadcast stream, but we kind of pretended that it was single

subscription.

So the only thing that listened to items fetch right here was items output.

And because there is only one thing listening to it, the transformer was only applied to incoming values

exactly one time, and that allowed us to sidestep that big issue around the use of all of our stream

builders.

From there.

We eventually got some information into our news list.

Oh, one thing that we forgot right here, we forgot right here.

We left in this very bad call inside of the newsless build method.

Well, we'll leave that in for right now.

I'll let you fix it up on your own, because that actually brings us back to a very important topic

inside of our dirt file.

Inside of after we did our navigation setup inside of here, we put together the on generates route

call back with the routes method right here.

So for every possible route that we could visit, we returned a material page route and inside that

material, Patriots builder method, we had said that we could do some very easy setup right here for

the screen.

And so, like we had just said a second ago, we have inside of news list the constructor method of

the build method.

Right here we have fetch top IDs, a very good place to relocate.

This call right here would have been into the material page route for the news list.

And so I'll let you do that.

Refactor on your own if you want to.

Certainly where we're doing that call right now is not the worst thing we can get away with it inside

of this very particular application.

But on your own application, you generally don't want to do any data loading from that build method

of an individual screen.

So we had the navigation side of here that set up some navigation to a very particular route, and so

a good example of doing that data loading was for the news detail, which is right here.

We got access to our comments block.

We pulled out some information from the path that we were trying to navigate to or the neighbor out

we were trying to navigate to.

And then we did some initial data loading.

And from there we finally went into our individual screens of new detail and new list and started up

the actual rendering process.

