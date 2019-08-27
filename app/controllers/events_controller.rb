# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :user_logged_in?, only: %i[new create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @user = current_user
    event = @user.events.build(event_params)
    if event.save
      redirect_to event_path(event)
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:description, :date)
  end
end
