class SchedulesController < ApplicationController
    layout "default"

    before_action :verify_authenticated

    # GET /schedules
    def index
    end

    # POST /schedules/store
    def store
        @schedule = Schedule.new(
            user_id: current_user.id,
            title: params[:title],
            description: params[:description],
            notification_type: params[:notification_type],
            notification_minutes: params[:notification_minutes]
        )

        if params[:event_tags].length > 0
            event_tags = params[:event_tags]
            @schedule.events_tag = event_tags.join(",")
        end

        if params[:all_day]
            @schedule.all_day = params[:all_day]
        else
            @schedule.start_time = params[:start_time]
            @schedule.end_time = params[:end_time]
        end

        if params[:repeat_weekly]
            @schedule.repeat_day = params[:repeat_day]
        else
            @schedule.start_date = params[:start_date]
            @schedule.end_date = params[:end_date]
        end

        if @schedule.save
            guest_permissions = params[:guest_permissions]
            guest_permissions.each do |key, value|
                # print "Key: ", key, " | Value: ", value, "\n"
                GuestPermission.create(
                    schedule_id: @schedule.id,
                    name: key,
                    value: value
                )
            end
            if params[:guests].length > 0
                guest_names = params[:guests]
                guest_names.each do |guest_name|
                    # print "Key: ", key, " | Value: ", value, "\n"
                    Guest.create(
                        schedule_id: @schedule.id,
                        username: guest_name
                    )
                end
            end

            render json: {
                "message": "Success",
                "schedule": @schedule
            }
        else
            render json: {
                "message": "Error",
                "schedule": @schedule
            }, status: 400
        end
    end

    private

    def verify_authenticated
        redirect_to root_path unless current_user
    end
end
