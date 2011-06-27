require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe GenericPlatform do
    subject do
      Platform
    end

    describe "#bsd?" do
      it "should return true on BSD flavors or false otherwise" do
        if RUBY_PLATFORM =~ /freebsd|openbsd|netbsd/i
          should be_bsd
        else
          should_not be_bsd
        end
      end
    end

    describe "#unix?" do
      it "should return true on Linux and BSD flavors or false otherwise" do
        if RUBY_PLATFORM =~ /linux|freebsd|openbsd|netbsd/i
          should be_unix
        else
          should_not be_unix
        end
      end
    end

    describe "#linux?" do
      it "should return true on Linux or false otherwise" do
        if RUBY_PLATFORM =~ /linux/i
          should be_linux
        else
          should_not be_linux
        end
      end
    end

    describe "#mac?" do
      it "should return true on MacOS or false otherwise" do
        if RUBY_PLATFORM =~ /darwin/i
          should be_mac
        else
          should_not be_mac
        end
      end
    end

    describe "#windows?" do
      it "should return true on Windows or false otherwise" do
        if RUBY_PLATFORM =~ /mswin/i
          should be_windows
        else
          should_not be_windows
        end
      end
    end

    describe "#default_browser" do
      it "returns a known browser" do
        subject.default_browser.should match /iexplore|firefox|chrome|safari|konqueror|opera/i
      end
    end

    describe "#default_text_editor" do
      it "returns a known text editor" do
        subject.default_text_editor.should match /notepad|vim|gedit|textedit/i
      end
    end
  end
end
