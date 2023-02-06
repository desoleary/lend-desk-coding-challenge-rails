# README

### Getting Started
```shell
$ git clone git@github.com:desoleary/lend-desk-coding-challenge-rails.git
$ cd lend-desk-coding-challenge-rails
$ bundle install
$ bin/rspec
$ bin/rake rswag:specs:swaggerize # Optionally re-generates API Docs
$ brew install redis # Optional
$ redis-server # runs redis server on port 6379
$ bin/rails c # Ensure you have OS redis installed and running under port 6379
$ open http://0.0.0.0:3000/api-docs # opens Swagger API Docs
```

### API Docs
- URL: http://0.0.0.0:3000/api-docs
- Regenerate API: `bin/rake rswag:specs:swaggerize`

### Contracts
Introduced validation contracts via `dry-validation` library

### Models (Redis)
Introduced `ApplicationEntry` in order to simplify redis model storage interactions

### Services (Light Services)
Service layer introduced to promote re-use and focus on single responsibilities via action classes.

- `add_errors`
  - adds `errors to context` and returns immediately from current action
  - `organizer fails` the context to ensure all subsequent actions do not get called when `ctx[:errors]` is filled

### TODO:
- Investigate why the need for `without_invalid_characters` via Swagger API calls
- Fix `BCrypt::Errors::InvalidHash:invalid hash` error encountered via Swagger API call `/users/sign_in` 
- Uncomment `CSRF` `protect_from_forgery` and fix Swagger API calls
- Hide the likes of below from organizer params/input
  - **password**
  - **password_confirmation**
- Implement reset password endpoints 
  - `POST /users/password` creates reset password token
  - `PUT /users/password` updates password when provided valid `token`
  - Ensure password is reset within a certain amount of time e.g. 6 hours
  - Send notification emails
- Implement `lock account` via max invalid credential attempts
- **logging** ~ remove any sensitive data
- **non api only**
  - Implement reset session after configured inactivity e.g. after 30 minutes
  - CAPTCHA on failed logins
- Implement rate limiting based client identifier e.g. max 1000 requests per hour
- Complete `CORS` configuration
- Ensure Redis interactions cannot be maliciously accessed via the likes of Cross Site Scripting`(XSS)`
- Run bundle audit prior via git remote push
