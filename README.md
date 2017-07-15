# Usage
```
bundle install --path=vendor/bundle
cd src
# generate parser
bundle exec racc conf_parse.y -o parse.rb
ruby exec.rb ../sample/sample_nginx.conf
```

The following is stdout of the above command.
```
Result of parse
[["user", "www www", nil],
 ["worker_processes", "5", nil],
 ["error_log", "logs/error.log", nil],
 ["pid", "logs/nginx.pid", nil],
 ["worker_rlimit_nofile", "8192", nil],
 ["events", nil, [["worker_connections", "4096", nil]]],
 ["http",
  nil,
  [["include", "conf/mime.types", nil],
   ["include", "/etc/nginx/proxy.conf", nil],
   ["include", "/etc/nginx/fastcgi.conf", nil],
   ["index", "index.html index.htm index.php", nil],
   ["default_type", "application/octet-stream", nil],
   ["log_format",
    "main '$remote_addr - $remote_user [$time_local]  $status '\n'\"$request\" $body_bytes_sent \"$http_referer\" '\n'\"$http_user_agent\" \"$http_x_forwarded_for\"'",
    nil],
   ["access_log", "logs/access.log  main", nil],
   ["sendfile", "on", nil],
   ["tcp_nopush", "on", nil],
   ["server_names_hash_bucket_size", "128", nil],
   ["server",
    nil,
    [["listen", "80", nil],
     ["server_name", "domain1.com www.domain1.com", nil],
     ["access_log", "logs/domain1.access.log  main", nil],
     ["root", "html", nil],
     ["location", "~ \\.php$", [["fastcgi_pass", "127.0.0.1:1025", nil]]]]],
   ["server",
    nil,
    [["listen", "80", nil],
     ["server_name", "domain2.com www.domain2.com", nil],
     ["access_log", "logs/domain2.access.log  main", nil],
     ["location",
      "~ ^/(images|javascript|js|css|flash|media|static)/",
      [["root", "/var/www/virtual/big.server.com/htdocs", nil],
       ["expires", "30d", nil]]],
     ["location", "/", [["proxy_pass", "http://127.0.0.1:8080", nil]]]]],
   ["upstream",
    "big_server_com",
    [["server", "127.0.0.3:8000 weight=5", nil],
     ["server", "127.0.0.3:8001 weight=5", nil],
     ["server", "192.168.0.1:8000", nil],
     ["server", "192.168.0.1:8001", nil]]],
   ["server",
    nil,
    [["listen", "80", nil],
     ["server_name", "big.server.com", nil],
     ["access_log", "logs/big.server.access.log main", nil],
     ["location", "/", [["proxy_pass", "http://big_server_com", nil]]]]]]]]

List of used directive
["user",
 "worker_processes",
 "error_log",
 "pid",
 "worker_rlimit_nofile",
 "events",
 "worker_connections",
 "http",
 "include",
 "index",
 "default_type",
 "log_format",
 "access_log",
 "sendfile",
 "tcp_nopush",
 "server_names_hash_bucket_size",
 "server",
 "listen",
 "server_name",
 "root",
 "location",
 "fastcgi_pass",
 "expires",
 "proxy_pass",
 "upstream"]

List of values by directive
{"user"=>["www www"],
 "worker_processes"=>["5"],
 "error_log"=>["logs/error.log"],
 "pid"=>["logs/nginx.pid"],
 "worker_rlimit_nofile"=>["8192"],
 "events"=>[nil],
 "worker_connections"=>["4096"],
 "http"=>[nil],
 "include"=>
  ["conf/mime.types", "/etc/nginx/proxy.conf", "/etc/nginx/fastcgi.conf"],
 "index"=>["index.html index.htm index.php"],
 "default_type"=>["application/octet-stream"],
 "log_format"=>
  ["main '$remote_addr - $remote_user [$time_local]  $status '\n'\"$request\" $body_bytes_sent \"$http_referer\" '\n'\"$http_user_agent\" \"$http_x_forwarded_for\"'"],
 "access_log"=>
  ["logs/access.log  main",
   "logs/domain1.access.log  main",
   "logs/domain2.access.log  main",
   "logs/big.server.access.log main"],
 "sendfile"=>["on"],
 "tcp_nopush"=>["on"],
 "server_names_hash_bucket_size"=>["128"],
 "server"=>
  [nil,
   "127.0.0.3:8000 weight=5",
   "127.0.0.3:8001 weight=5",
   "192.168.0.1:8000",
   "192.168.0.1:8001"],
 "listen"=>["80"],
 "server_name"=>
  ["domain1.com www.domain1.com",
   "domain2.com www.domain2.com",
   "big.server.com"],
 "root"=>["html", "/var/www/virtual/big.server.com/htdocs"],
 "location"=>
  ["~ \\.php$", "~ ^/(images|javascript|js|css|flash|media|static)/", "/"],
 "fastcgi_pass"=>["127.0.0.1:1025"],
 "expires"=>["30d"],
 "proxy_pass"=>["http://127.0.0.1:8080", "http://big_server_com"],
 "upstream"=>["big_server_com"]}
```
