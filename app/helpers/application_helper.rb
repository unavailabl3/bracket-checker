module ApplicationHelper
    def get_stats
        if @check_data.is_a?(Array)
            stats = {
                amount: @check_data.size,
                valid: @check_data.count{|r| r[:valid] == true}
            }
        else
            stats = {
                amount:1,
                valid: @check_data[:valid] ? 1 : 0
            }
        end
        stats
    end

    def check_data_array
        @check_data.is_a?(Array) ? @check_data : [@check_data]
    end
end
