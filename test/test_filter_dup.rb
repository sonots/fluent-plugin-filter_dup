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

  def emit(config, msgs)
    es = Fluent::MultiEventStream.new
    msgs.each { |msg|
      es.add(@time, msg)
    }

    d = create_driver(config)
    d.filter_stream('filter.test', es)
  end

  sub_test_case 'configure' do
    test 'check default' do
      assert_nothing_raised { create_driver }
    end
  end

  sub_test_case 'filter_stream' do
    test 'dup' do
      msg = {"message" => "foo"} 
      es = emit('', [msg])
      assert_equal([msg, msg], es.instance_variable_get(:@record_array))
    end
  end
end
