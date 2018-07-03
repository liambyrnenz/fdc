# Liam Byrne (byrneliam2)
# fdc

require 'set'

class GeneratorProcess

    attr_accessor :printer

    def initialize(schema, fds, printer)
        # Accept properly formatted strings (which will be turned into an array)
        # or an array itself (assumed to be)
        @schema = schema.is_a?(String) ? format_schema(schema) : schema
        @fds = fds.is_a?(String) ? format_fds(fds) : fds
        @printer = printer
    end

    def format_schema(schema)
        # Format the schema as an ordered array. TODO?
        # This is so when we work on it, results are produced in the input order.
        return schema[2...schema.length - 1].split(',')
    end

    def format_fds(fds)
        _fds = []
        fds[1...fds.length - 1].split(';').each do |d|
            ds = d.split('/')
            _fds << FuncDependency.new(ds[0], ds[1])
        end
        return _fds
    end

end

class FuncDependency

    attr_accessor :lhs, :rhs

    def initialize(lhs, rhs)
        @lhs = lhs.is_a?(String) ? setify(lhs) : lhs
        @rhs = rhs.is_a?(String) ? setify(rhs) : rhs
    end

    # Turn a comma-separated string into a set
    def setify(str)
        Set.new(str.split(','))
    end

    def ==(obj) # force equality to be on set components
        obj.is_a?(FuncDependency) && @lhs == obj.lhs && @rhs == obj.rhs
    end

end