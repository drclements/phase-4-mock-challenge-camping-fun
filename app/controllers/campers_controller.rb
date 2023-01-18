class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    

    def index 
        # render json: Camper.all, except: [:created_at, :updated_at]

        #with serializer working
        render json: Camper.all
    end

    def show 
        camper = Camper.find(params[:id])
        # render json: camper, except: [:created_at, :updated_at], include: [activities: {except: [:created_at, :updated_at] }]

        #with serializer
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

private
    
    def camper_params 
        params.permit(:name, :age)
    end

    def render_unprocessable_entity invalid 
        render json: {errors: invalid.message}, status: :unprocessable_entity
    end

    def record_not_found 
        render json: {error: "Camper not found"}, status: :not_found
    end
    
end
