# Site Parser

API to index page content that is found inside h1, h2, h3 and links.

## Setup

Follow these steps to run for local development:

1. Install ruby

2. bundle install

3. rake db:create and rake db:migrate 

4. rails s

## Base URL
```
/v1/sites
```

### Index
- Method: `GET`

### Create
- Params: `url(string, url format)`
- Method: `POST`
- Content is collected in background (sidekiq), so, it can take some time to process

## Resource Representation
Field                           |  Type          | Optional |
--------------------------------|----------------|----------|
id                              |  Integer       |          |
url                             |  String        |          |
processed                       |  Boolean       |          |
content                         |  Text          |  Yes     |
created_at                      |  Time          |          |
updated_at                      |  Time          |          |
