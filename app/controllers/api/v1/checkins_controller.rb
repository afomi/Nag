class Api::V1::CheckinsController < ApplicationController
  protect_from_forgery except: [:new_from_foursquare]

  def index
    @checkins = Checkin.limit(30).order("created_at DESC")

    render json: @checkins
  end

  def new_from_foursquare
    checkin = JSON.parse params["checkin"]
    user = JSON.parse params["user"]
    secret = params["secret"]

    text = "Checked in at #{checkin["venue"]["name"]}\n\n#{checkin["id"]}"
    lat = checkin["venue"]["location"]["lat"]
    lng = checkin["venue"]["location"]["lng"]

    new_checkin = {
      text: text,
      latitude: lat,
      longitude: lng
    }
    @checkin = Checkin.create new_checkin

    render json: @checkin
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def show
    @checkin = Checkin.find(params[:id])
    render json: @checkin
  end

  def create
    @checkin = Checkin.new(params[:checkin].permit(:text, :latitude, :longitude))

    if @checkin.save
      format.html {
        redirect_to(new_checkin_path, notice: 'Checkin was successfully created.')
      }
      render json: @checkin
    else
      render json: @checkin.errors, status: :unprocessable_entity
    end
  end

  def update
    @checkin = Checkin.find(params[:id])

    if @checkin.update_attributes(params[:checkin])
      format.json { head :ok }
    else
      render json: @checkin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    return false # for now

    @checkin = Checkin.find(params[:id])
    if @checkin.destroy
      render json: true
    else
      render json: false
    end
  end
end
