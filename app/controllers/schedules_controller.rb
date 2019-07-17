class SchedulesController < ApplicationController

    def index
        @schedules = Schedule.all
        json_response(@schedules)
    end

    def create
        if Schedule.where( name: params[:name] ).empty?
            @schedule = Schedule.create!({name: params[:name]})
            json_response(@schedule, :created)
        else
            json_response({ error: "Schedule already exists by that name!"})
        end
    end

    def show
        @schedule = Schedule.includes(:appointments).where( id: params[:id] ).order('appointments.start_date ASC').to_json(:include => :appointments)
        json_response(@schedule)
    end

    def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy
        head :no_content
    end
end
