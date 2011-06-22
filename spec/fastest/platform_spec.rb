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

      it "should build a concrete platform" do
        should be_kind_of Platform
      end
    end

    describe "#linux?" do
      it "should return true on a Linux OS" do
        next unless subject.kind_of? Linux
        should be_kind_of Linux
      end
    end

    describe "#lmac?" do
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

  end
end
