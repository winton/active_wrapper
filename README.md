ActiveWrapper
=============

Wraps ActiveRecord and Logger for use in non-Rails environments.

Compatibility
-------------

Maintained under Ruby 1.9.2.

Setup
-----

<pre>
gem install active_wrapper
</pre>

Usage
-----

<pre>
require 'rubygems'
require 'active_wrapper'

$db, $log = ActiveWrapper.setup(
  :base => File.dirname(__FILE__),
  :env => 'development',
  :log => 'custom',
  :stdout => true
)

$db.drop_db
$db.create_db
$db.establish_connection
$db.generate_migration('my_migration')
$db.migrate('001')
$db.migrate_reset
$log.info('log this')
$log.clear
</pre>

<code>ActiveWrapper</code> looks for the following files within the <code>:base</code> directory:

* <b>config/database.yml</b>
* <b>db/migrate/*.rb</b>

The <code>:env</code> option is <code>"development"</code> by default.

Logger
------

In the previous example, the log is stored in <b>log/custom.log</b>.

If no <code>:log</code> name is specified, the <code>:env</code> option is used for the log name.

You may also set <code>:log</code> to false to disable logging entirely.

Setting <code>:stdout</code> to true causes stdout and stderr to redirect to the logger. It is false by default.

Rakefile
--------

Add this to your project's <b>Rakefile</b> for database migration and log tasks:

<pre>
require 'rubygems'
require 'rake'
require 'active_wrapper/tasks'

ActiveWrapper::Tasks.new(:log => 'custom') do
  # Put stuff you would normally put in the environment task here
end
</pre>

Pass the same options to <code>ActiveWrapper::Tasks.new</code> as you would <code>ActiveWrapper.new</code>.