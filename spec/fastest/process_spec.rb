require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe Process do
    describe '.current' do
      subject do
        Process.current
      end

      it 'should have the current PID' do
        subject.pid.should == ::Process.pid
      end

      it 'should contain the full path to ruby' do
        ruby_path = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])
        ruby_path = File.expand_path(ruby_path)
        subject.path.should == ruby_path
      end
    end

    describe '.all' do
      subject do
        Process.all
      end

      it 'should return a hash of processes' do
        should be_kind_of Hash
        subject.each do |pid, process|
          process.should be_kind_of Process
        end
      end

      it 'should be a non-empty' do
        should_not be_empty
      end

      it 'should index processes by their corresponding PID' do
        subject.each do |pid, process|
          pid.should == process.pid
        end
      end

      it 'should contain the current process' do
        subject[::Process.pid].should_not be_nil
        subject[::Process.pid].should == Process.current
      end
    end
  end
end
