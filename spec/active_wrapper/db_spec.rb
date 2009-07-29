require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveWrapper::Db do
  
  before(:each) do
    $db, $log, $mail = ActiveWrapper.setup(
      :base => SPEC + '/example_project',
      :env => 'test'
    )
    $db.drop_db
    $db.create_db
  end
  
  it "should establish a connection" do
    $db.disconnect!
    $db.establish_connection
    $db.connected?.should == true
  end

  it "should create a database" do
    $db.current_database.should == 'active_wrapper_test'
  end

  it "should drop a database" do
    $db.drop_db
    $db.current_database.should == nil
  end
  
  it "should migrate a database" do
    $db.migrate
    $db.execute('insert into tests () values ()')
    $db.execute('select * from tests').num_rows.should == 1
  end
  
  it "should migrate reset a database" do
    $db.migrate
    $db.execute('insert into tests () values ()')
    $db.migrate_reset
    $db.execute('select * from tests').num_rows.should == 0
  end
  
  it "should generate a migration" do
    $db.generate_migration 'another_test'
    path = SPEC + "/example_project/db/migrate/002_another_test.rb"
    File.exists?(path).should == true
    FileUtils.rm_f path
  end
end
