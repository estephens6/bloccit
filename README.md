== README

## Bloccit: a Reddit replica to teach the fundamentals of web development and Rails.

Made with my mentor at [Bloc](http://bloc.io).

To load rails server: :
# rails s -p $PORT -b $IP

To remove files that you don't need:
git clean -f -d

To reset database:

rake db:reset

then migrate database

rake db:migrate

To revert back to last commit
git reset --hard HEAD