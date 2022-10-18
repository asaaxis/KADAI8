class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  
  def index
    @pictures = Picture.all
  end

  
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end


  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
  end

  def edit
  end

  
  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to picture_url(@picture), notice: "Picture was successfully created." 
    else
      render :new
    end
  end


  def update
    if @picture.update(picture_params)
      redirect_to picture_url(@picture), notice: "Picture was successfully updated." 
    else
      render :edit
    end
  end


  def destroy
    @picture.destroy
    redirect_to pictures_url, notice: "Picture was successfully destroyed." 
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end


    def picture_params
      params.require(:picture).permit(:image, :image_cache, :content, :user_id)
    end
end
