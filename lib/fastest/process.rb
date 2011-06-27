module Fastest
  # Generic Process class.
  # @abstract
  class GenericProcess
    include Comparable
    extend Enumerable

    # @return [Fixnum] the process id
    attr_reader :pid

    # @return [Time] the process creation time
    attr_reader :created_at

    # @return [Fixnum] the parent process id
    attr_reader :ppid

    # @return [String] the full process path
    attr_reader :path

    # @return [String] the command line passed to the process
    attr_reader :cmd_line

    def initialize (pid, created_at, ppid = nil, path = nil, cmd_line = nil)
      @pid = pid
      @created_at = created_at
      @ppid = ppid
      @path = path
      @cmd_line = cmd_line
    end

    # Compares receiver process against another
    # @param [GenericProcess] target process to compare against
    # @return [-1, 0, 1] implementation of Comparable's <=>
    def <=> (process2)
      cmp = (pid <=> process2.pid)
      if cmp != 0
        cmp
      else
        created_at <=> process2.created_at
      end
    end

    # Iterate over all currently running processes
    # @return [Enumerator] each enumerator for all Process objects
    def self.each (&block)
      all.each_value(&block)
    end

    # Returns the process object having the given PID
    # @param [Fixnum] the PID of the process to be inspected
    # @return [GenericProcess] the process object for the given PID
    def self.by_pid (pid)
      all[pid]
    end

    # Returns the current process object
    # @return [GenericProcess] the process object for the current process
    def self.current
      by_pid(::Process.pid)
    end
  end
end
