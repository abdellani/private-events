class AttendancesController < ApplicationController
  before_action :is_user_logged_in
  def create
    @attendance=Attendance.new(event_id:params[:event_id],attendee_id:current_user.id)
    @event=@attendance.event
    if @event.attendees.none?{|a| a.id ==current_user.id} && @attendance.save
      redirect_to user_path(current_user)
    else
      redirect_to root_path
    end

  end
end