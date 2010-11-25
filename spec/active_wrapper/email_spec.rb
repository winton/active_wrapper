require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveWrapper::Email do
  
  before(:each) do
    $db, $log, $mail = ActiveWrapper.setup(
      :base => $root + '/spec/example_project',
      :env => 'test'
    )
  end
  
  it "should set instance variables" do
    $mail.base.should =~ %r{active_wrapper/spec/example_project}
    $mail.config.should == {
      :sendmail => nil,
      :smtp => {
        :address => "smtp.gmail.com",
        :authentication => :plain,
        :domain => "mydomain.com",
        :password => "password",
        :port => 587,
        :enable_starttls_auto => true,
        :user_name => "test@mydomain.com"
      }
    }
    $mail.env.should == 'test'
  end
  
  it "should set Pony defaults" do
    Pony.options.should == {
      :via => :smtp,
      :via_options => $mail.config[:smtp]
    }
  end
end