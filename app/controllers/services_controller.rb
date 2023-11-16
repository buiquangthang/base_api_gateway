class ServicesController < ApplicationController
  # TODO: need add authenticate again after add authenticate with LDAP
  skip_before_action :authenticate

  before_action :set_service, except: [:index, :new, :create]

  # GET /services
  def index
    @services = Service.all
  end

  # GET /services/1
  def show
    render json: @service
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # POST /services
  def create
    result = ::Operations::Services::Create.call(service_params.to_h)

    respond_to do |format|
      if result.success?
        format.html { redirect_to services_url, notice: "Service was successfully created" }
      else
        @errors = result.failure
        @service = Service.new(service_params)
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /services/:id
  def edit; end

  # PATCH/PUT /services/1
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_url, notice: "Service was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    redirect_to services_url, notice: "Service was successfully deleted."
  end

  # POST /service/:id/toggle
  def toggle
    render json: { message: "Success" }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def service_params
      params.require(:service).permit(:name, :url, :token)
    end
end
