class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity 

    def index 
        render json: Camper.all, status: :ok
    end

    def show 
        camper = find_camper
        render json: camper, serializer: CamperActivitiesSerializer, status: :ok 
    end

    def create 
        new_camper = Camper.create!(camper_params)
        render json: new_camper, status: :created 
    end

    private 

    def find_camper 
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found
        render json: { error: "Camper not found" }, status: :not_found 
    end

    def render_unprocessable_entity invalid 
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end


end
