# Inactive

This project has been inactive since 2010, since [Wesabe's closure](http://blog.precipice.org/why-wesabe-lost-to-mint).

## Site

This code powers [Ohnomymoney.com](http://ohnomymoney.com).  It's a Ruby app running on Sinatra.

### Loading data

Money data can be loaded from either the [Wesabe](http://wesabe.com) API or the [Buxfer](http://buxfer.com) API.  Ohnomymoney uses Wesabe as of this writing, as Buxfer [doesn't look like it's doing very well](http://getsatisfaction.com/buxfer/products/buxfer_wwwbuxfercom).  

You'll want to set up an account on one of the two sites, and then fill out the corresponding YML file in the /updaters directory.  The YML setup is a clunky workaround for having a real frontend interface for connecting local accounts to Wesabe or Buxfer accounts.


### User accounts

I want to open up the site to other users, but that's difficult now, with how unreliable the state of bank scraping is online.  When that situation improves, I'll be more inclined to do it.

## License

[MIT License](LICENSE).
