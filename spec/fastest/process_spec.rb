require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe GenericProcess do
    before(:each) do
      @now = Time.now
      @all_hashes = {
        :init => Process.new(1, @now - 100, 0, 'init', '/sbin/init', '/sbin/init'),
        :kthreadd => Process.new(2, @now - 100, 0, 'kthreadd', nil, 'kthreadd'),
        :sshd => Process.new(623, @now - 80, 1, 'sshd', nil, '/usr/sbin/sshd -D'),
        :bash => Process.new(1150, @now - 50, 1, 'bash', '/bin/bash', 'bash'),
        :chrome => Process.new(2140, @now - 40, 1150, 'chrome', '/opt/google/chrome/chrome', '/opt/google/chrome/chrome'),
        :ruby => Process.new(3410, @now - 30, 1150, 'ruby', '/usr/bin/ruby', '/usr/bin/ruby my_script param1'),
        :orphan => Process.new(3110, @now - 51, 1150, 'orphan', '/usr/bin/orphan', 'orphan of 1150 (not bash)')
      }
      @all = @all_hashes.values.shuffle!
      # stub the process table
      Sys::ProcTable.stub(:ps) do |pid|
        unless pid.nil?
          @all.find do |process|
            process.pid == pid
          end
        else
          @all
        end
      end
      Process.stub(:sys_process_to_process) do |process|
        Process.new(process.pid, process.created_at, process.ppid, process.name, process.path, process.cmd_line)
      end
      # return ruby as the current process
      ::Process.stub(:pid).and_return(3410)
      ::Process.stub(:ppid).and_return(1150)
    end

    describe '#<=>' do
      it 'should only sort by PID and creation time' do
        process1 = Process.new(10, @now, 1, 'ls', '/bin/ls', '/dir')
        process2 = Process.new(10, @now, 2, 'cat', '/bin/cat', '/file')
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

    describe '#parent' do
      it 'should return the parent if it still exists' do
        @all_hashes[:sshd].parent.should == @all_hashes[:init]
        @all_hashes[:bash].parent.should == @all_hashes[:init]
        @all_hashes[:chrome].parent.should == @all_hashes[:bash]
        @all_hashes[:ruby].parent.should == @all_hashes[:bash]
      end

      it 'should return nil if the parent does not exist' do
        @all_hashes[:init].parent.should be_nil
        @all_hashes[:kthreadd].parent.should be_nil
      end

      it 'should return nil for orphan objects whose parent ID is being reused' do
        @all_hashes[:orphan].parent.should be_nil
      end

      it 'should cache the parent process (even if nil)' do
        Process.should_receive(:by_pid).with(@all_hashes[:orphan].ppid).exactly(1).times
        @all_hashes[:orphan].parent.should be_nil
        Process.rspec_verify
        Process.should_not_receive(:by_pid)
        @all_hashes[:orphan].parent.should be_nil
      end
    end

    it 'should behave like an enumerable' do
      Process.should respond_to :any?
      Process.should respond_to :include?
      Process.should respond_to :inject
      Process.should respond_to :map
      Process.should respond_to :select
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

      it 'should consist of all running processes' do
        should == @all
      end

      it 'should cache all parents' do
        Process.should_not_receive(:by_pid)
        subject.each do |process|
          process.parent
        end
      end
    end

    describe '.each' do
      subject do
        Process.each
      end

      it 'should be an enumerator' do
        subject.should be_kind_of Enumerator
      end

      it 'should contain processes' do
        subject do |process|
          process.should be_kind_of Process
        end
      end

      it 'should consist of all running processes' do
        subject.map.sort.should == @all.sort
      end
    end

    describe '.by_pid' do
      it 'should return the process for the given PID' do
        @all.each do |process|
          Process.by_pid(process.pid).should == process
        end
      end

      it 'should return nil for a non-existent PID' do
        Process.by_pid(9999).should be_nil
      end

      it 'should return nil if passed pid is nil' do
        Process.by_pid(nil).should be_nil
      end
    end

    describe '.current' do
      subject do
        Process.current
      end

      it 'should be ruby' do
        should == @all_hashes[:ruby]
      end
    end
  end
end
