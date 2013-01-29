require 'rubygems' unless defined? Gem
# For a faster start times
# from: https://github.com/janlelis/irbtools
require 'irbtools/configure'
Irbtools.remove_library :paint
Irbtools.remove_library :fancy_irb
Irbtools.add_library :paint, :late => true do Wirb.load_schema :classic_paint if defined? Wirb end
Irbtools.add_library :fancy_irb, :thread => -1 do FancyIrb.start end
Irbtools.start
require 'awesome_print'

unless IRB.version.include? 'DietRB'
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end
