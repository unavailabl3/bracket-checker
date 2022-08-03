# ExpressionsCheckService class
# to check bracket expressions

# input parameters:
#   (expressions: String)
#    Valid symbols: "[", "]", "(", ")", "<", ">", "{", "}"
#     single string (example "[]") or
#     multiline separated by "\n" (example "[]\n[]")
#   (detailed: Boolean)
#     for short valid/invalid output (example false) or
#     for detailed Hash output (example
#       {expression: String, valid: Boolean, error: String}
#     )

# output parameters:
#   true/false for short single expression or
#   Hash for detailed single expression or
#   Array of Booleans for short multiline expressions or
#   Array of Hashes for detailed multiline expressions

# Examples:
#  ExpressionsCheckService.call('[]', false) #short single expression
#  ExpressionsCheckService.call('[]') #detailed single expression
#  ExpressionsCheckService.call("[]\n[]", false) #short multiline expressions
#  ExpressionsCheckService.call("[]\n[]") #detailed multiline expressions

class ExpressionsCheckService < ApplicationService
    def initialize(expressions, detailed = true)
      @expressions = expressions
      @detailed = detailed
    end

    def call
        raise TypeError, "expected a String" unless @expressions.is_a?(String)
        check_data = []
        expressions_array = @expressions.split("\n")
        expressions_array = [''] if expressions_array.size == 0
        expressions_array.each do |expression|
            if @detailed
                check_data << check_expression(expression)
            else
                check_data << check_expression(expression)[:valid]
            end
        end
        return check_data[0] if check_data.size == 1
        return check_data
    end

    private

    def check_expression(expression)
        result_data = {
            expression: expression,
            valid: false
        }

        if (expression =~ /^[\[\]\(\)\{\}\<\>]*$/).nil?
            result_data[:error] = 'Expression contains invalid symbols'
            return result_data
        end

        chars = expression.chars
        brackets = []
        chars.each_with_index do |char, index|
            if ['[','(','{','<'].include?(char)
                brackets.append(char)
            else
                if brackets.size == 0
                    result_data[:error] = "Error in position:#{index+1}, expecting opening brackets"
                    return result_data
                end
                current_char = brackets.pop
                if current_char == '(' && char != ")"
                    result_data[:error] = "Error in position:#{index+1}, expecting ')' symbol"
                    return result_data
                end
                if current_char == '{' && char != "}"
                    result_data[:error] = "Error in position:#{index+1}, expecting '}' symbol"
                    return result_data
                end
                if current_char == '<' && char != ">"
                    result_data[:error] = "Error in position:#{index+1}, expecting '>' symbol"
                    return result_data
                end
                if current_char == '[' && char != "]"
                    result_data[:error] = "Error in position:#{index+1}, expecting ']' symbol"
                    return result_data
                end
            end
        end
        if brackets.size == 0
            result_data[:valid] = true
        else
            result_data[:error] = "Error in last position, expecting closing brackets for '#{brackets.join}'"
        end
        return result_data
    end
end
