# BracketChecker

The bracket expression syntax checker.
There are four different types of brackets "[", "(", "<", "{" and their closing counterparts "]", ")", ">", "}". With these brackets expressions like "[]", "[<>({}){}[([])<>]]" or "((((((()))))))" can be build.

Valid symbols: "[", "]", "(", ")", "<", ">", "{", "}"

- Main logic (Checker) as a Service Object inside `app/services/`
- specs (RSpec) inside `spec/services` and `spec/requests`

# Two ways to start

- Live check at Heroku [https://salty-mountain-54772.herokuapp.com/](https://salty-mountain-54772.herokuapp.com/)
- Manual test ([Github gist](https://gist.github.com/unavailabl3/5d46bdf9c73cbce39624bc76fd7530c7)) using `app/services/application_service.rb` and `app/services/expressions_check_service.rb`

## Dependencies

- ruby-2.5.1
- rails-5.2.8

## Installation

Configure `config/database.yaml`. Adjust the config to
match your development environment.

Run the following commands.

```bash
bundle install
bundle exec rails db:drop db:setup
```

Let's make sure everything is ready.

```bash
bundle exec rspec
rails server
```
## Examples

```
ExpressionsCheckService.call('[]', false) #short single expression
# => true
ExpressionsCheckService.call('[]') #detailed single expression
# => {:expression=>"[]", :valid=>true}
ExpressionsCheckService.call("[]\n[]", false) #short multiline expressions
# => [true, true]
ExpressionsCheckService.call("[]\n[]") #detailed multiline expressions
# => [{:expression=>"[]", :valid=>true}, {:expression=>"[]", :valid=>true}]
```
## Assignment

- Implement a checker for expressions of brackets. It should be possible to feed an expression into it and to know if this expression is valid or not.
- Allow multiple line support where each line is a separate expression. Return a result that reports for each line that it is either valid or invalid.  In case the expression is invalid also return the first invalid bracket, if existing, and which rule was broken by it.
