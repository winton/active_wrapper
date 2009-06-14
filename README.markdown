ActiveWrapper
=============

Wraps ActiveRecord and Logger for use in non-Rails environments.

Setup
-----

<pre>
sudo gem install active_wrapper
</pre>

Usage
-----

<pre>
require 'rubygems'
require 'active\_wrapper'

$db, $log = ActiveWrapper.new(
  :base => File.dirname('__FILE__'),
  :env => 'development',
  :log => 'custom.log',
  :stdout => true
)

$db.establish\_connection
$db.generate\_migration('my_migration')
$db.migrate('001')
$db.migrate\_reset
$log.info('log this')
$log.clear
</pre>

<code>ActiveWrapper</code> looks for the following files within <code>:base</code>:

* <i>config/database.yml</i>
* <i>db/migrate/*.rb</i>

The <code>:env</code> option is "development" by default.

Logger
------

In the previous example, the log is stored in <i>log/custom.log</i>.

If no <code>:log</code> name is specified, the <code>:env</code> option is used for the log name.

You may also set <code>:log</code> to false to disable logging entirely.

Setting <code>:stdout</code> to true causes stdout and stderr to redirect to the logger. It is false by default.

Rakefile
--------

Add this to your project's <i>Rakefile</i> for database migration and log tasks:

<pre>
require 'rubygems'
require 'rake'
require 'active\_wrapper/tasks'

ActiveWrapper::Tasks.new(:log => 'custom.log') do
  # Put stuff you would normally put in the environment task here
end
</pre>

Pass the same options to <code>ActiveWrapper::Tasks.new</code> as you would <code>ActiveWrapper.new</code>.