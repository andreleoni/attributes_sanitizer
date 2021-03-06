module AttributesSanitizer
  class SanitizerProc
    include Comparable

    attr_reader :id

    def initialize(sanitizer)
      raise ArgumentError, "No sanitizer given" if sanitizer.nil?

      if sanitizer.is_a?(Proc)
        @proc = sanitizer
        @id = sanitizer.object_id
      else
        @proc = AttributesSanitizer.sanitizers[sanitizer]
        raise ArgumentError, "No attribute sanitizer defined for #{sanitizer}" if @proc.nil?

        @id = sanitizer
      end
    end

    def <=>(another_proc)
      self.id <=> another_proc.id
    end

    def call(value)
      @proc.call(value)
    end
  end
end
