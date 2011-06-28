Given /^(.*) is not running$/ do |process_name|
  process_path = path_to(process_name)
  Fastest::Process.any? do |process|
    process.path == process_path 
  end.should == false
end

When /^I run (.*)$/ do |process_name|
  process_path = path_to(process_name)
  Fastest::Process.run process_path
end
