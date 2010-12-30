require 'spec_helper'

describe ActiveWrapper::Gems do
  
  before(:each) do
    @old_config = ActiveWrapper::Gems.config
    
    ActiveWrapper::Gems.config.gemspec = "#{$root}/spec/fixtures/gemspec.yml"
    ActiveWrapper::Gems.config.gemsets = [
      "#{$root}/spec/fixtures/gemsets.yml"
    ]
    ActiveWrapper::Gems.config.warn = true
    
    ActiveWrapper::Gems.gemspec true
    ActiveWrapper::Gems.gemset = nil
  end
  
  after(:each) do
    ActiveWrapper::Gems.config = @old_config
  end
  
  describe :activate do
    it "should activate gems" do
      ActiveWrapper::Gems.stub!(:gem)
      ActiveWrapper::Gems.should_receive(:gem).with('rspec', '=1.3.1')
      ActiveWrapper::Gems.should_receive(:gem).with('rake', '=0.8.7')
      ActiveWrapper::Gems.activate :rspec, 'rake'
    end
  end
  
  describe :gemset= do
    before(:each) do
      ActiveWrapper::Gems.config.gemsets = [
        {
          :name => {
            :rake => '>0.8.6',
            :default => {
              :externals => '=1.0.2'
            }
          }
        },
        "#{$root}/spec/fixtures/gemsets.yml"
      ]
    end
    
    describe :default do
      before(:each) do
        ActiveWrapper::Gems.gemset = :default
      end
      
      it "should set @gemset" do
        ActiveWrapper::Gems.gemset.should == :default
      end
    
      it "should set @gemsets" do
        ActiveWrapper::Gems.gemsets.should == {
          :name => {
            :rake => ">0.8.6",
            :default => {
              :externals => '=1.0.2',
              :rspec => "=1.3.1"
            },
            :rspec2 => { :rspec => "=2.3.0" }
          }
        }
      end
    
      it "should set Gems.versions" do
        ActiveWrapper::Gems.versions.should == {
          :rake => ">0.8.6",
          :rspec => "=1.3.1",
          :externals => "=1.0.2"
        }
      end
    
      it "should set everything to nil if gemset given nil value" do
        ActiveWrapper::Gems.gemset = nil
        ActiveWrapper::Gems.gemset.should == nil
        ActiveWrapper::Gems.gemsets.should == nil
        ActiveWrapper::Gems.versions.should == nil
      end
    end
    
    describe :rspec2 do
      before(:each) do
        ActiveWrapper::Gems.gemset = "rspec2"
      end
      
      it "should set @gemset" do
        ActiveWrapper::Gems.gemset.should == :rspec2
      end
    
      it "should set @gemsets" do
        ActiveWrapper::Gems.gemsets.should == {
          :name => {
            :rake => ">0.8.6",
            :default => {
              :externals => '=1.0.2',
              :rspec => "=1.3.1"
            },
            :rspec2 => { :rspec => "=2.3.0" }
          }
        }
      end
    
      it "should set Gems.versions" do
        ActiveWrapper::Gems.versions.should == {
          :rake => ">0.8.6",
          :rspec => "=2.3.0"
        }
      end
    end
    
    describe :nil do
      before(:each) do
        ActiveWrapper::Gems.gemset = nil
      end
      
      it "should set everything to nil" do
        ActiveWrapper::Gems.gemset.should == nil
        ActiveWrapper::Gems.gemsets.should == nil
        ActiveWrapper::Gems.versions.should == nil
      end
    end
  end
  
  describe :reload_gemspec do
    it "should populate @gemspec" do
      ActiveWrapper::Gems.gemspec.hash.should == {
        "name" => "name",
        "version" => "0.1.0",
        "authors" => ["Author"],
        "email" => "email@email.com",
        "homepage" => "http://github.com/author/name",
        "summary" => "Summary",
        "description" => "Description",
        "dependencies" => ["rake"],
        "development_dependencies" => ["rspec"]
       }
    end
  
    it "should create methods from keys of @gemspec" do
      ActiveWrapper::Gems.gemspec.name.should == "name"
      ActiveWrapper::Gems.gemspec.version.should == "0.1.0"
      ActiveWrapper::Gems.gemspec.authors.should == ["Author"]
      ActiveWrapper::Gems.gemspec.email.should == "email@email.com"
      ActiveWrapper::Gems.gemspec.homepage.should == "http://github.com/author/name"
      ActiveWrapper::Gems.gemspec.summary.should == "Summary"
      ActiveWrapper::Gems.gemspec.description.should == "Description"
      ActiveWrapper::Gems.gemspec.dependencies.should == ["rake"]
      ActiveWrapper::Gems.gemspec.development_dependencies.should == ["rspec"]
    end
  
    it "should produce a valid gemspec" do
      ActiveWrapper::Gems.gemset = :default
      gemspec = File.expand_path("../../../active_wrapper.gemspec", __FILE__)
      gemspec = eval(File.read(gemspec), binding, gemspec)
      gemspec.validate.should == true
    end
  end
end
