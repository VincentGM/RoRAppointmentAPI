class AppointmentsController < ApplicationController
    def create
        if !params[:start_date].nil? && !params[:end_date].nil? && Integer(params[:end_date]) > Integer(params[:start_date])

            @appointment_conflicts = Appointment.where(["schedule_id = :schedule_id AND ((start_date BETWEEN :start_date AND :end_date) OR (end_date BETWEEN :start_date AND :end_date))",
                {schedule_id: params[:schedule_id], start_date: params[:start_date], end_date: params[:end_date]}]).count

            if(@appointment_conflicts > 0)
                return render json: { error: "Your appointment conflicts with another appointment." }, status: :unprocessable_entity
            end

            @schedule = Schedule.find( params[:schedule_id] )

            if !@schedule
                render json: { error: "Schedule with that ID not found!" }, status: :not_found
            else
                @appointment = Appointment.create!(start_date: params[:start_date], end_date: params[:end_date], schedule_id: params[:schedule_id])
                json_response(@appointment, :created)
            end

        else
            render json: { error: "Invalid fields!" }, status: :unprocessable_entity
        end
    end

    def show
        @appointments = Appointment.find(schedule_id: params[:schedule_id])
        json_response(@appointments)
    end

    def destroy
        @appointment = Appointment.find(id: params[:id])
        @appointment.destroy
        head :no_content
    end

    def index
        @appointments = Appointment.all
        json_response(@appointments)
    end
end
