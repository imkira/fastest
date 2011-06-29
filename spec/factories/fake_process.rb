require 'ostruct'

class FakeProcess < OpenStruct; end

Factory.sequence :pid do |n|
  n
end

Factory.define :fake_process do |f|
  f.pid do
    Factory.next(:pid)
  end

  f.created_at do |p|
    Time.at(0) + p.pid
  end

  f.ppid 0

  f.name do |p|
    "proc_#{p.pid}"
  end

  f.path do |p|
    path = ['/usr/bin', '/usr/sbin', '/bin'].sample
    "#{path}/#{p.name}"
  end

  f.cmd_line do |p|
    # random list of arguments
    args = rand(5).times.inject([]) do |args, arg|
      args << rand(99999)
    end
    if args.empty?
      p.path
    else
      "#{p.path} #{args.join ' '}"
    end
  end
end
