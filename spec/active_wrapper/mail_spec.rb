require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveWrapper::Db do
  
  before(:each) do
    $db, $log, $mail = ActiveWrapper.setup(
      :base => SPEC + '/example_project',
      :env => 'test'
    )
  end
  
  it "should set instance variables" do
    $mail.base.should =~ %r{active_wrapper/spec/example_project}
    $mail.config.should == {
      :sendmail => false,
      :smtp => {
        :address => "smtp.gmail.com",
        :authentication => :plain,
        :domain => "mydomain.com",
        :password => "password",
        :port => 587,
        :enable_starttls_auto => true,
        :user_name => "test@mydomain.com"
      },
      :imap => {
        :password => "password",
        :port => 993,
        :server => "imap.gmail.com",
        :ssl => true,
        :use_login => true,
        :username => "test@mydomain.com"
      }
    }
    $mail.env.should == 'test'
  end
end