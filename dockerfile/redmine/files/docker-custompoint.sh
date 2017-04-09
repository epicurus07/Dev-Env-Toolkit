#ckeditor
git clone https://github.com/a-ono/redmine_ckeditor.git /usr/src/redmine/plugins/redmine_ckeditor

#slack
git clone https://github.com/sciyoshi/redmine-slack.git /usr/src/redmine/plugins/redmine_slack

#github
git clone https://github.com/koppen/redmine_github_hook.git /usr/src/redmine/plugins/redmine_github_hook

#agile
bundle lock --add-platform java
bundle lock --add-platform x86-mingw32 x64-mingw32 x86-mswin32 java
wget -O redmine_agile.zip http://email.redmineup.com/c/eJxFzrFuwzAMBNCvkceAEiVSHjQUKPIbgSRSjVtbCRyn_v04U4Cb3nB3kloYI5ZhSiFKFHbADuXSyFnQygQBfA3Gw6qyTF2f99OSp3m4Ji6-2Tg2gCKFYkYmpeqLFQkkOA5zum7b3eCXcecj-76fPiX1thw2T1X7Qy9L7vlH10OQwVuD5-32p93gN6COpEUzOG1RHAFrqXyoQqicHUVrhzVJ_33IU8DC-2zP_7q-N15SxkPr
unzip redmine_agile.zip -d /usr/src/redmine/plugins

bundle install --without development test
rake redmine:plugins:migrate RAILS_ENV=production
