require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe 'Platform' do
    subject do
      Platform
    end

    describe "#unix?" do
      it "should return true on a Unix-like OS" do
        next unless subject.kind_of? Unix
        should be_kind_of Unix
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
