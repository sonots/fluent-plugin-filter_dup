module Fluent
  class DupFilter < Filter
    Plugin.register_filter('dup', self)
  
    def configure(conf)
      super
    end

    def filter_stream(tag, es)
      new_es = MultiEventStream.new
      es.each { |time, record|
        begin
          new_es.add(time, record)
          new_es.add(time, record)
        rescue => e
          router.emit_error_event(tag, time, record, e)
        end
      }
      new_es
    end
  end
end
