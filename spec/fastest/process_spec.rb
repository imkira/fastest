require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe GenericProcess do
    describe '#<=>' do
      before(:each) do
        @now = Time.now
      end

      it 'should only sort by PID and creation time' do
        process1 = Process.new(10, @now, 1, '/bin/ls', '/dir')
        process2 = Process.new(10, @now, 2, '/bin/cat', '/file')
        process1.should == process2
        process2.should == process1
      end

      it 'should sort by PID (in ascending order)' do
        process1 = Process.new(10, @now)
        process2 = Process.new(11, @now)
        process1.should < process2
        process2.should > process1
      end

      it 'should sort by creation time (in ascending order)' do
        process1 = Process.new(10, @now + 10)
        process2 = Process.new(10, @now)
        process1.should > process2
        process2.should < process1
      end

      it 'should first sort by PID' do
        process1 = Process.new(10, @now + 10)
        process2 = Process.new(11, @now)
        process1.should < process2
        process2.should > process1
      end
    end

    describe '.by_pid' do
      it 'should return the process for the current PID' do
        Process.by_pid(::Process.pid).pid.should == ::Process.pid
      end

      it 'should return the process for the parent PID' do
        Process.by_pid(::Process.pid).ppid.should == ::Process.ppid
      end
    end

    describe '.current' do
      subject do
        Process.current
      end

      it 'should have the current PID' do
        subject.pid.should == ::Process.pid
      end

      it 'should have the parent PID' do
        subject.ppid.should == ::Process.ppid
      end

      it 'should contain the full path to ruby' do
        ruby_path = File.join(Config::CONFIG['bindir'], Config::CONFIG['ruby_install_name'])
        subject.path.should == File.expand_path(ruby_path)
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

      it 'should be non-empty' do
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

    it 'should behave like an enumerable' do
      Process.should respond_to :any?
      Process.should respond_to :include?
      Process.should respond_to :inject
      Process.should respond_to :map
      Process.should respond_to :select
    end

    describe '.each' do
      it 'should be an enumerator' do
        Process.each.should be_kind_of Enumerator
      end

      it 'should be non-empty' do
        Process.each.should be_any
      end

      it 'should contain processes' do
        Process.each do |process|
          process.should be_kind_of Process
        end
      end

      it 'should contain the current process' do
        Process.each.any? do |process|
          process.pid == ::Process.pid
        end.should == true
      end
    end
  end
end
