class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :update, :destroy]

  # GET /routes
  def index
    @routes = Route.all

    render json: @routes
  end

  # GET /routes/1
  def show
    render json: @route
  end

  # POST /routes
  def create
    @route = Route.new(route_params)

    if @route.save
      DynamicRouter.reload
      render json: @route, status: :created, location: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /routes/1
  def update
    if @route.update(route_params)
      DynamicRouter.reload
      render json: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # DELETE /routes/1
  def destroy
    @route.destroy
    DynamicRouter.reload
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find_by_id(params[:id])

      render json: { error: 'Route not found' }, status: :not_found unless @route
    end

    # Only allow a trusted parameter "white list" through.
    def route_params
      params.require(:route).permit(:service_id, :verb, :url_pattern, :version)
    end
end
