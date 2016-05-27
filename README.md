# Project Status
* _Running Properly_
* Front-end website repository [here](https://github.com/sarunyou/ProjectSearch)

# Source Code Description
[./search.pig](./search.pig]) _Pig script for searching_
[./server.rb](./server.rb]) _Ruby as Web API_

# To Run Server
ruby server.rb

# Known Issues
- Slow processing time (50 seconds for each API request)

# Dependencies

##Install Pig Latin using Homebrew
$ brew install pig

##Install Redis using Homebrew
$ brew install redis

##Install Ruby Gem Dependencies
$ gem install sinatra
$ gem install redis
$ gem install thread
$ gem install colorize
$ gem install awesome_print