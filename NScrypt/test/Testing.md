# Testing Overview #

Using MiniTest for RubyOnRails. see [http://guides.rubyonrails.org/testing.html](http://guides.rubyonrails.org/testing.html)

Directories:
- Unit tests and functional tests in `models` and `controllers` folder
- Integration tests in `integration` folder

Run a test by `bin/rake test` e.g.:
`cd scms/NScrypt/`; 
    bin/rake test test/models/minute_test.rb

Uses fixtures in `test/fixtures` 
setup in `test/test_helper.rb`

## Contract Workflow ##

###Unassigned###

see `user_flows_test.rb` in `~/scms/NScrypt/test/integration$`

run: `bin/rake test test/integration/user_flows_test.rb`

using codes.yml