require File.dirname(__FILE__) + '/../spec_helper'

describe PlanoConta do
  it "should have a valid factory" do
    Factory(:plano_conta).should be_valid
  end
end
