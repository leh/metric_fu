require 'spec'

require File.dirname(__FILE__) + '/../lib/metric_fu/base'
include MetricFu

describe MetricFu::Base::Generator do
  describe "save_html" do
    it "should save to a index.html in the base_dir" do
      @generator = MetricFu::Base::Generator.new('base_dir')
      @generator.should_receive(:open).with("base_dir/index.html", "w")
      @generator.save_html("<html>")
    end
              
    it "should save to a custom.html to the base_dir if 'custom' is passed as name" do
      @generator = MetricFu::Base::Generator.new('base_dir')
      @generator.should_receive(:open).with("base_dir/metric_fu/custom.html", "w")
      @generator.save_html("<html>", 'metric_fu/custom')
    end        
  end
  
  describe "generate_report class method" do
    it "should create a new Generator and call generate_report on it" do
      @generator = mock('generator')
      @generator.should_receive(:generate_report)
      MetricFu::Base::Generator.should_receive(:new).and_return(@generator)
      MetricFu::Base::Generator.generate_report('base_dir')      
    end                  
  end 
  
  describe "generate_report" do
    it "should create a new Generator and call generate_report on it" do
      @generator = MetricFu::Base::Generator.new('other_dir')
      @generator.should_receive(:open).with("other_dir/index.html", "w")
      @generator.should_receive(:generate_html).and_return('<html>')
      @generator.generate_report
    end                  
  end   
end