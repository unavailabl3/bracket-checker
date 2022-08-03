class ApplicationController < ActionController::Base
    def index
    end

    def check
        if params[:expressions]
            @check_data = ExpressionsCheckService.call(params[:expressions])
        end
        render 'layouts/_check_results', layout: false
    end
end
