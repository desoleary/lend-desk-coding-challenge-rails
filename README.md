# README

### API Docs
- URL: http://0.0.0.0:3000/api-docs
- Regenerate API: `bin/rake rswag:specs:swaggerize`

### Light Services
- `add_errors`
  - adds `errors to context` and returns immediately from current action
  - `organizer fails` the context to ensure all subsequent actions do not get called when `ctx[:errors]` is filled

### TODO:

- Hide the likes of below from organizer params/input
  - **password**
  - **password_confirmation**

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
