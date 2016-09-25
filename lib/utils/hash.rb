module Utils
  module HashMethods
    refine Hash do
      def deep_dup
        Marshal.load(Marshal.dump(self))
      end
    end
  end
end