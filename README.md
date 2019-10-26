# Yaqb

#### Yet Another Query Builder
Yaqb is query builder that will filter, sort and paginate your ActiveRecord collections.

In addition to query building, presenters are used to manage what a consumer of your API can query.

## Installation

In your Gemfile

```ruby
# Choose your preferred pagination gem
gem 'kaminari' # or
gem 'will_paginate' # or
gem 'pagy'

# Then add
gem 'yaqb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yaqb

## Configuration

By default, Yaqb will detect if you are using Kaminari, WillPaginate, or Pagy. If you want to change any of the configurable settings, you may do so:

```ruby
Yaqb.configure do |config|
  # If for whatever reason you are using multiple pagination gems, you can manually set which gem to use.
  config.paginator = :kaminari # :will_paginate, :pagy
end
```

## Usage

### Controllers

In your controller, you will need to include the following the module: `Yaqb::Base`

```ruby
class ApplicationController < ActionController::Base # or ActionController::API
  include Yaqb::Base
end

# And then to use Yaqb

class BooksController < ApplicationController
  def index
    # #orchestrate expects a collection and a presenter.
    # #orchestrate return a results object meaning you will have access to the following methods:
    # #scope - This is your collection after being filtered, sorted and paginated
    # #links - This returns a hash of links based on the paginated results.
    result = orchestrate(Books.all, BookPresenter)

    # Depending on your serializer you can render your data as so:
    # BluePrinter gem by procore is used here:
    render json: BookBlueprint.render(request.scope, root: :data, meta: { links: request.links })
  end
end
```

### Presenters

Presenters will allow you to control what a consumer of your API can sort and filter by.

Your Presenter class will need to inherit from `Yaqb::Presenter`

```ruby
class BookPresenter < Yaqb::Presenter
  sort_by :id, :title, :created_at, :updated_at
  filter_by :id, :title
end
```

### Handling Errors

By default Yaqb will rescue from any query errors with `QueryBuilderError` and return that error to the consumer

Given the following API call:

`GET https://api.example.com/v1/books?per=a`

The following response will be returned

```json
{
  "error": {
    "message": "Invalid pagination params. Only numbers are supported for \"page\" and \"per\"",
    "invalid_params": "per=a"
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yaqb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yaqb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yaqb/blob/master/CODE_OF_CONDUCT.md).
