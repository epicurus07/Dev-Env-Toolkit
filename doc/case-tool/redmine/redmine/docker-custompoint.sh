#ckeditor
git clone https://github.com/a-ono/redmine_ckeditor.git /usr/src/redmine/plugins/redmine_ckeditor
# Agile
wget -O redmine_agile.zip http://email.redmineup.com/c/eJxFjkEOgjAQRU9TlmY6paVddGFivAZpZwZFoRhAub51ZfJXb_Hf4zjY4E1uxmh9JgB0OXjyPbIOzkEQsKB5UC2swvNY5P06zWmcmnukAOJ0GJIl471rGYnAWuhazixWmine9_2lzFnhte44jtP_hJa5smkkKZv0cyrpJmslBlGjMtd9eUpR5gJGgpMsCVAGz-igk0xdpTWNuoTOa92skctj4zeDBltjS_rI-nN8AaGcREo
unzip redmine_agile.zip

bundle install --without development test
rake redmine:plugins:migrate RAILS_ENV=production
