require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

describe ActiveWrapper::Log do
  
  before(:each) do
    FileUtils.rm_f(@path = SPEC + "/example_project/log/test.log")
    $db, $log, $mail = ActiveWrapper.setup(
      :base => SPEC + '/example_project',
      :env => 'test'
    )
  end
  
  it "should create a log file" do
    File.exists?(@path).should == true
  end
  
  it "should log to the log file" do
    $log.info "test"
    File.read(@path).include?('test').should == true
  end
  
  it "should clear the log file while keeping the logger intact" do
    $log.clear
    File.read(@path).include?('test').should == false
    $log.info "test"
    File.read(@path).include?('test').should == true
  end
end