module Fastest
  module Linux 
    # Process class for the Linux platform (see {GenericProcess})
    class Process < Fastest::Unix::Process
      # Returns the current process object
      # @return [GenericProcess] the process object for the current process
      def self.current
        # this is faster than just indexing #all by the current PID
        sys_process_to_process Sys::ProcTable.ps(::Process.pid)
      end

      # Return all currently executing processes
      # @return [Hash] hash of currently running processes indexed by their PID
      def self.all
        Sys::ProcTable.ps.inject({}) do |procs, process|
          procs[process.pid] = sys_process_to_process(process)
          procs
        end
      end

      private

      # Convert a Struct::ProcTableStruct entry into a Fastest::Process
      # @param [Struct::ProcTableStruct] process structure returned by Sys::ProcTable.ps
      # @return [Process] corresponding Fastest::Process
      def self.sys_process_to_process (process)
        # starttime as reported by /proc is the number of jiffies since last boot
        created_at = Fastest::Platform.system_boot_time
        created_at += process.starttime / Fastest::Platform.system_clock_tick.to_f
        Process.new(process.pid, created_at, process.ppid, process.exe, process.cmdline)
      end
    end
  end
end
