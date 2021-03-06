class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]  
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :is_owner?, only: [:edit, :update, :destroy]
  before_action :is_admin?, only: [:create]  
  
  # GET /restaurants
  # GET /restaurants.json
  def index
        @restaurants = Restaurant.order(created_at: :DESC).page(params[:page]).per(8)
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :location, :tel, :delivery, :package, :runtime, :sale, :menuimg, :image, :user_id, :range, :point1, :point2, :foodtype)
    end

    def is_owner?
      if( current_user == @restaurant.user || current_user.id==1 || current_user.id==2 || current_user.id==3 || current_user.id==4 || current_user.id==5 || current_user.id==6 || current_user.id==7 || current_user.id==8  )      
      else
        redirect_to @restaurant  
      end
    end       
    
    def is_admin?
      if( current_user.id==1 || current_user.id==2 || current_user.id==3 || current_user.id==4 || current_user.id==5 || current_user.id==6 || current_user.id==7 || current_user.id==8 )      
      else
        redirect_to '/restaurants'
      end
    end  
end
