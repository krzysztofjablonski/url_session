# UrlSession

UrlSession stores your session in memcache (dalli), puts session_id to every url and parses it in midleware

![Chrome url bar with UrlSession enabled](https://img.skitch.com/20120524-pp89sj3c5i5tf27id698gdw6y9.jpg "UrlSession in action")

## Installation

    $ gem install url_session

## Usage

Add gem to your Gemfile

```ruby
gem 'url_session'
```

configure session_store to use url_session (session_store.rb)
```ruby
UrlSessionExample::Application.config.session_store :url_session_store, :namespace => 'sessions',
  :key =>"_session", :compress => true, :expire_after => 1.day, :cookie_enabled => false, :param => 'session_id'
```

and include UrlSession in your ApplicationController

```ruby
class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  include UrlSession::Controller
end
```


You can put your all routes in session_id scope, if you want (routes.rb)

```ruby
scope "/(:session_id)" do
  resources :sessions
  resources :users
  resources :posts
  ...
  match '/'  => 'posts#index',   :as => :root # root :to => 'posts#index' doesn't work here
end
```

## Options

The same like dalli_store plus:

```ruby
:param => 'PHPSESSID'    # name of session id parameter, default 'session_id'
:cookie_enabled => false # try to use cookie before url, default false
```

## Example

https://github.com/rubymaster/url_session-example

http://url-session-example.herokuapp.com

