require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Fastest
  describe Platform do
    subject do
      Platform.instance
    end

    describe ".instance" do
      it "should return a platform instance" do
        should be_kind_of Platform
      end
    end

    describe "#mac?" do
      it "should return true on a mac" do
        next unless subject.kind_of? Mac
        should be_kind_of Mac
      end
    end
  end
end
