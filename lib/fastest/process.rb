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

    # @return [String] the process name
    attr_reader :name

    # @return [String] the full process path
    attr_reader :path

    # @return [String] the command line passed to the process
    attr_reader :cmd_line

    def initialize(pid, created_at, ppid = nil, name = nil, path = nil, cmd_line = nil)
      @pid = pid
      @created_at = created_at
      @ppid = ppid
      @name = name
      @path = path
      @cmd_line = cmd_line
    end

    # Compares receiver process against another
    # @param [GenericProcess] target process to compare against
    # @return [-1, 0, 1] implementation of Comparable's <=>
    def <=>(process2)
      cmp = (pid <=> process2.pid)
      if cmp != 0
        cmp
      else
        created_at <=> process2.created_at
      end
    end

    # Returns the current working directory for the process
    # @return [String] the current working directory
    def working_dir
      update.cwd
    end

    alias_method :cwd, :working_dir

    # Returns parent process object
    # @return [GenericProcess] the parent process object
    def parent
      # cache even if result is nil (cannot use ||= here)
      if defined? @parent
        @parent
      else
        @parent = Process.checked_parent(self, Process.by_pid(@ppid))
      end
    end

    # Return all currently executing processes
    # @return [Array] array of currently running processes
    def self.all
      procs_by_pid = {}
      # get all processes
      Sys::ProcTable.ps.each do |process|
        process = sys_process_to_process(process)
        procs_by_pid[process.pid] = process
      end
      # cache all parents
      procs_by_pid.values.map do |process|
        parent = checked_parent(process, procs_by_pid[process.ppid])
        process.instance_variable_set :@parent, parent
        process
      end
    end

    # Iterate over all currently running processes
    # @return [Enumerator] each enumerator for all Process objects
    def self.each(&block)
      all.each(&block)
    end

    # Returns the process object having the given PID
    # @param [Fixnum] the PID of the process to be inspected
    # @return [GenericProcess] the process object for the given PID
    def self.by_pid(pid)
      unless pid.nil?
        process = Sys::ProcTable.ps(pid)
        unless process.nil?
          sys_process_to_process process
        end
      end
    end

    # Returns the current process object
    # @return [GenericProcess] the process object for the current process
    def self.current
      by_pid(::Process.pid)
    end

    private

    # Returns passed parent if it is valid, or nil if this process is orphan
    # @param [GenericProcess] the process to be checked
    # @param [GenericProcess] the parent process to be checked
    # @return [GenericProcess, nil] parent if it is valid, or nil otherwise
    def self.checked_parent(process, parent)
      # parent must exist and must have been created before this one
      unless parent.nil? or parent.pid != process.ppid or parent.created_at > process.created_at
        parent 
      end
    end

    # Returns the updated information for the process
    # @return [Struct::ProcTableStruct] current process structure
    def update
      Sys::ProcTable.ps(@pid)
    end
  end
end
