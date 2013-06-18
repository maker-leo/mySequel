## MySequel

This is an exercise in which you need to use some more advanced SQL skills in order to find out some information about a dataset of famous movie sequels.

### The exercise

First of all fork and clone [this repository](https://github.com/maker-leo/mySequel) from github.

You will see in **/spec/exercises_spec.rb** are a number of pending specifications. Get them to pass to complete the exercise.

Note you can use either `find_by_sql` in order to run your SQL using basically raw SQL or for a more ruby like way you can use active record methods to do all of the answers (e.g. you can use the `sum` method)

### The data

Although we don't normally recommend using fixtures in this example it makes sense to quickly add some dummy data into your databases. You'll see the data in the fixtures folder, to get it into your database just run `db:test:prepare` (after running `db:setup` first).

Remember this will only add the fixture data to your test database which is **not** the database used when you run `rails dbconsole` you'll need to connect to your test database instead.