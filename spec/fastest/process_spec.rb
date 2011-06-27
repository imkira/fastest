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

      it 'should have the current working directory' do
        subject.working_dir.should == Dir.getwd
      end

      it 'should detect changes to the working directory' do
        basedir = File.dirname(Dir.getwd)
        cur_proc = subject
        Dir.chdir basedir do
          cur_proc.working_dir.should == basedir
        end
      end
    end

    describe '.all' do
      subject do
        Process.all
      end

      it 'should return an array of processes' do
        should be_kind_of Array
        subject.each do |process|
          process.should be_kind_of Process
        end
      end

      it 'should be non-empty' do
        should_not be_empty
      end

      it 'should contain the current process' do
        subject.select do |process|
          process == Process.current
        end.size.should == 1
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
