# markdown watcher

markdown file compile to html file.

## use

    % bundle install
    % bundle exec watchr md.watch

watching start md/*.md files.

## example

write md/README.md

    % bundle exec watchr md.watchr
    [2013-02-16 12:34:27 +0900] INFO generate file => html/README.html (src:md/README.md)

`open html/README.html` show html page.

