This code powers ohnomymoney.com, a website for broadcasting, visualizing, and discussing one's money.  It's a social money site.

It also serves as a playground and showcase for the latest in social graph and integration APIs.  Namely, this thing is going to integrate cleanly with Pubsubhubbub, Salmon (and thus Google Buzz) and will take advantage of Google's already-activated support for the PortableContacts and Webfinger protocols.

Users will signup using either a Webfinger-enabled email (this includes all Gmail addresses), or an OpenID - no passwords accepted or stored.


Getting the Money
=================================

Money loading is done by sitting on top of Buxfer, a Mint competitor that provides an API over its data.  Sadly, the Buxfer API currently only supports plain HTTP authentication, so I have to ask users for their Buxfer username and password, which sucks.  In the interim, as I set this site up for just myself, I'll just store my Buxfer username/password somewhere and use that to populate my money.

I'd much prefer that Buxfer give me a better way of accessing their API, like OAuth for example, before I open it for public signups.  But, if I get impatient enough, I may launch anyway and just be really clear about why I would ask for someone's Buxfer credentials and deal with the smaller crowd willing to give them to me.
