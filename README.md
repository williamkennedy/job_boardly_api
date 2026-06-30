# JobBoardlyApi

A Ruby wrapper around the [Jobboardly](https://jobboardly.com) Management and Headless Board APIs.

## Installation

Add this line to your application's Gemfile:

```bash
bundle add job_boardly_api
```

Or install it yourself as:

```bash
gem install job_boardly_api
```

## Usage

Every request returns a `JobBoardlyApi::Response` object. You can call `body` or `to_object` on it to get either the JSON hash or a Ruby object.

### Management API

You will need an API key from Jobboardly. Find it in the app under `Settings → Board → API access`.

```ruby
client = JobBoardlyApi::Client.new(api_key: ENV["JOBBOARDLY_API_KEY"])

# Or target a specific board host
client = JobBoardlyApi::Client.new(api_key: ENV["JOBBOARDLY_API_KEY"], board_host: "jobs.example.com")
```

### Board & Metadata

```ruby
response = client.me
response.body => Hash of the JSON body
response.to_object => OpenStruct

response = client.categories
response = client.category(1)
response = client.arrangements
```

### Jobs

```ruby
response = client.jobs(page: 1, per: 50)
response = client.create_job(
  title: "API Engineer",
  company_name: "Acme",
  application_link: "mailto:jobs@acme.com",
  description: "<div>Build APIs</div>",
  location: "remote"
)
response = client.job(123)
response = client.update_job(123, title: "Senior API Engineer")
response = client.delete_job(123)
response = client.publish_job(123)
response = client.unpublish_job(123)
response = client.restore_job(123)
response = client.job_counts
response = client.bulk_draft_jobs([1, 2, 3])
response = client.bulk_publish_jobs([1, 2, 3])
response = client.bulk_expire_jobs([1, 2, 3])
response = client.bulk_destroy_jobs([1, 2, 3])
```

### Blog Posts

```ruby
response = client.blog_posts(state: "published")
response = client.create_blog_post(title: "Hello World")
response = client.blog_post(1)
response = client.update_blog_post(1, title: "Hello Universe")
response = client.delete_blog_post(1)
response = client.publish_blog_post(1)
response = client.unpublish_blog_post(1)
```

### Prices & Employer Products

```ruby
response = client.prices
response = client.price(1)
response = client.employer_products
response = client.employer_product(1)
```

### Memberships

```ruby
response = client.membership_subscriptions(page: 1)
response = client.grant_membership_subscription(
  email: "customer@example.com",
  membership_plan_id: 1,
  external_ref: "unique-ref"
)
response = client.membership_subscription("unique-ref")
response = client.revoke_membership_subscription("unique-ref")

response = client.membership_purchases(page: 1)
response = client.grant_membership_purchase(
  email: "customer@example.com",
  membership_plan_id: 1,
  external_ref: "unique-ref"
)
response = client.membership_purchase("unique-ref")
response = client.revoke_membership_purchase("unique-ref")
```

### Entitlements

```ruby
response = client.employer_entitlements(page: 1)
response = client.grant_employer_entitlement(
  email: "customer@example.com",
  employer_product_id: 1,
  external_ref: "unique-ref"
)
response = client.employer_entitlement("unique-ref")
response = client.cancel_employer_entitlement("unique-ref")

response = client.candidate_entitlements(page: 1)
response = client.grant_candidate_entitlement(
  email: "customer@example.com",
  candidate_product_id: 1,
  external_ref: "unique-ref"
)
response = client.candidate_entitlement("unique-ref")
response = client.cancel_candidate_entitlement("unique-ref")
```

### Job Payments

```ruby
response = client.job_payments(page: 1)
response = client.grant_job_payment(
  job_id: 123,
  amount_cents: 5000,
  external_ref: "unique-ref"
)
response = client.job_payment("unique-ref")
response = client.revoke_job_payment("unique-ref")
response = client.revoke_job_payment("unique-ref", unpublish: false)
```

## Headless Board API

The Headless API is public and does not require an API key. It is used for rendering a board from a custom frontend.

```ruby
# Using board host
client = JobBoardlyApi::HeadlessClient.new(board_host: "jobs.example.com")

# Or using board id via central API
client = JobBoardlyApi::HeadlessClient.new(board_id: 42)
```

```ruby
response = client.bootstrap
response = client.jobs(page: 1, per: 10)
response = client.job(123)
response = client.categories
response = client.arrangements
response = client.places(q: "Berlin")
response = client.blog_posts(tag: "ruby")
response = client.blog_post("hello-world")
response = client.page("about-us")
response = client.employer_products
response = client.candidate_products
response = client.membership_plans
response = client.create_subscriber(
  subscriber: {
    email: "user@example.com"
  }
)
```

## Response Object

All API calls return a `JobBoardlyApi::Response`:

```ruby
response = client.me

response.success?  # => true/false
response.status    # => 200
response.headers   # => { "content-type" => "application/json" }
response.body      # => { "board" => { "id" => 1, ... } }
response.to_object # => #<OpenStruct board=#<OpenStruct id=1, ...>>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/williamkennedy/job_boardly_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
