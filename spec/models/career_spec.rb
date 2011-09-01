require 'spec_helper'

describe Career do
  describe "futures_pipeline" do
    it "should return a new FuturesPipeline client" do
      @test = Career.new.futures_pipeline
      @test.should be_a FuturesPipeline::Client
  end

  end

end
