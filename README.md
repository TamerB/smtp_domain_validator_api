# SMTP domain validator

This API uses https://mailboxlayer.com to check if a given email has an existing SMTP domain.

Note: At most 5 API requests per second are allowed


* Ruby version: 2.5.5

* Dependencies: Run ```bundle install```

* Configuration: You need to add ```API_ACCESS_KEY``` to ```.env```file.

* Database:
  - This API uses PostgreSQL. So make sure it is installed and with your username as a role
  - Run ```rails db:create```
  - Ten run ```rails db:migrate```
  - For production environment:
    - Run ```rake db:create RAILS_ENV=production```
    - Then run ```rake db:migrate RAILS_ENV=production```

* How to run the test suite: Run ```bundle exec rspec```

* Services: For now, just checking if SMTP domain exists

* Request example: ```http POST :3000/validation_requests email=tamer.bhgt@gmail.com```

* Response Messages and their status codes:
  - "Valid SMTP domain!": 200 (ok)
  - "Invalid SMTP domain!": 200 (ok)
  - "Bad Request... No email to validate!": 400 (bad_request)
  - "Validation Request denied: At most 5 api requests per second are allowed!": 405 (method_not_allowed)
