class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @plays = Play.all.order("created_at DESC")
  end

  def show
    @reviews =  @play.reviews.order("created_at DESC")
    unless @reviews.present?
     @avg_review = 0
    else
     @avg_review = @reviews.average(:rating).present? ? @reviews.average(:rating).round(2) : 0
    end
end

  def new
    @play = current_user.plays.build
  end

  def create
    @play = current_user.plays.build(play_params)

    if @play.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      render 'edit'
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director, :play_img)
  end

  def find_play
    @play = Play.find(params[:id])
  end
end
