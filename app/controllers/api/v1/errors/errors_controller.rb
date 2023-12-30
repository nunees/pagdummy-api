module Api
  module V1
    module Errors
      class ErrorsController < ApplicationController
        def not_found
          render json: { error: 'route not found' }
        end

        def unacceptable
          render json: { error: 'unprocessable operation' }
        end

        def internal_error
          render json: { error: 'Internal server error' }
        end
      end
    end
  end
end
