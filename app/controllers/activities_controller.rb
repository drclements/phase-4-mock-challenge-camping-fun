class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 

    def index 
        render json: Activity.all
    end

    def destroy 
        activity = Activity.find(params[:id])
        activity.destroy
        head :no_content
    end

private 

    def record_not_found 
        render json: {error: "Activity not found" }, status: :not_found
    end
    
end
