require_relative 'helper'
require 'fluent/plugin/filter_dup'

class DupFilterTest < Test::Unit::TestCase
  include Fluent

  setup do
    Fluent::Test.setup
    @time = Fluent::Engine.now
  end

  def create_driver(conf = '')
    Test::FilterTestDriver.new(DupFilter).configure(conf, true)
  end

  def filter(config, msgs)
    d = create_driver(config)
    d.run {
      msgs.each {|msg|
        d.filter(msg, @time)
      }
    }
    d.filtered_as_array
  end

  sub_test_case 'configure' do
    test 'check default' do
      assert_nothing_raised { create_driver }
    end
  end

  sub_test_case 'filter_stream' do
    test 'dup' do
      msg = {"message" => "foo"} 
      filtered = filter('', [msg])
      assert_equal([msg, msg], filtered.map {|e| e.fetch(2) })
    end
  end
end
