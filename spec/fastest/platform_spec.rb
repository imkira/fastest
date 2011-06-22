require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe Platform do
    subject do
      Platform.instance
    end

    describe ".instance" do
      it "should return the same object for multiple calls" do
        plat2 = Platform.instance
        plat3 = Platform.instance
        plat2.should === subject
        plat3.should === subject
      end

      it "should be exactly one of the supported platforms" do
        count = 0
        count += 1 if subject.linux?
        count += 1 if subject.mac?
        count.should be < 2
        count += 1 if subject.windows?
        count.should be == 1
      end
    end

    describe ".os" do
      it "should return the class for the current platform"do
        os = Platform.os
        count = 0
        count += 1 if os == Linux
        count += 1 if os == Mac
        count.should be < 2
        count += 1 if os == Windows
        count.should be == 1
      end
    end

    describe "#linux?" do
      it "should return true on a Linux OS" do
        next unless subject.kind_of? Linux
        should be_kind_of Linux
      end
    end

    describe "#mac?" do
      it "should return true on a Mac OS" do
        next unless subject.kind_of? Mac
        should be_kind_of Mac 
      end
    end

    describe "#windows?" do
      it "should return true on a Windows OS" do
        next unless subject.kind_of? Windows
        should be_kind_of Windows
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
