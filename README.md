# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Objectives:
* Use _Ruby_/_Rails_ for the BE
* Use _Rust_ (faster JSON parsing)
* Use _Elixir_ (Web crawler)
* Use _Traktor_ (Insert crawled results into DB)
* Use _VueJS_, _Elm_ or _GraphQL_ (SPA)
* Use _Bootstrap_ (3 or 4), _foundation_ (6) or _vanilla CSS_
* Leverage https://www.themoviedb.org to retrieve content
* Remove _Coffeescript_ (Don't work with Elm)

## Behaviors:
### BE/FE architecture:
* FE work as an SPA making calls to the BE.
* All the calls to external APIs are passing through the BE allowing to change it if necessary.
* BE will be leveraging BDD.
* Challenges:
  * Storage of the cookies
  * Management of the forms

### Home Page:
* Display current popular movies & TV shows:
  * Requirement(s):
    * Retrieve necessary informations from a source, which one?
* Display last visited movies & TV shows
  * Requirement(s):
    * Store informations from user.
* Display popular movies & TV shows:
  * Requirement(s):
    * Store informations from users.
