module Fastest
  module Linux 
    # Process class for the Linux platform (see {GenericProcess})
    class Process < Fastest::Unix::Process
      # Retrieve all currently executing processes
      # @return [Hash] hash of currently running processes indexed by their PID
      def self.all
        Dir.entries('/proc').inject({}) do |procs, pid|
          # ignore non-directories
          next procs unless File.directory?(path_to_proc_dir(pid))
          # ignore directories whose name are not numbers
          next procs unless pid =~ /^\d+$/
          # create process object
          pid = pid.to_i
          path = read_proc_path(pid)
          procs[pid] = Process.new(pid, nil, nil, path)
          procs
        end
      end

      private

      # Compute path to process information directory
      # @param [Fixnum] the pid number of the process to inspect
      # @return [String] the path to the folder of the given process information
      def self.path_to_proc_dir (pid)
        File.expand_path(File.join('/proc', pid.to_s))
      end

      # Read the full process path
      # @param [Fixnum] the pid number of the process to inspect
      # @note This method may return nil if you don't have permission to read the process path
      # @return [String, nil] the full path to the process or nil (e.g., permission denied)
      def self.read_proc_path (pid)
        exe_path = File.join(path_to_proc_dir(pid), 'exe')
        begin
          if File.symlink? exe_path
            File.expand_path(File.readlink(exe_path))
          end
        rescue
        end
      end
    end
  end
end
