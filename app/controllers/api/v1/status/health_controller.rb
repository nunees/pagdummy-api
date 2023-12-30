module Api
  module V1
    module Status
      class HealthController < ApplicationController
        def index
          render json: { message: 'API is healthy' }
        end
      end
    end
  end
end