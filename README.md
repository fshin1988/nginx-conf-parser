# Usage
```
bundle install --path=vendor/bundle
cd src
# generate parser
bundle exec racc conf_parse.y -o parse.rb
ruby exec.rb ../sample/sample_nginx.conf
```
