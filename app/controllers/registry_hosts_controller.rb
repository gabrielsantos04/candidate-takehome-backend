class RegistryHostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_filter_presence, only: :search

  def create
    @registry_host = RegistryHost.new(registry_host_params)
    if @registry_host.save
      render json: @registry_host, serializer: RegistryHostSerializer
    else
      render json: {
        error: "Registry host not created",
        msg: @registry_host.errors.full_messages.to_sentence
      }, status: :bad_request
    end
  end
  def list_all
    @registry_hosts = RegistryHost.all
    render json: @registry_hosts, each_serializer: RegistryHostSerializer
  end

  def search
    @registry_hosts = RegistryHost.where("source LIKE ? COLLATE NOCASE", "%#{params[:filter]}%")
    render json: @registry_hosts, each_serializer: RegistryHostSerializer
  end

  def show
    @registry_host = RegistryHost.find(params[:id])
    render json: @registry_host, serializer: RegistryHostSerializer
  rescue
    render json: { error: "Registry host not found" }, status: :not_found
  end

  def update_status
    @registry_host = RegistryHost.find(params[:id])
    if @registry_host.update(status: params[:status])
      render json: @registry_host, serializer: RegistryHostSerializer
    else
      render json: {
        error: "Registry host not updated",
        msg: @registry_host.errors.full_messages.to_sentence
      }, status: :bad_request
    end
  rescue
    render json: { error: "Registry host not found" }, status: :not_found
  end

  def update
    @registry_host = RegistryHost.find(params[:id])
    if @registry_host.update(registry_host_params)
      render json: @registry_host, serializer: RegistryHostSerializer
    else
      render json: {
        error: "Registry host not updated",
        msg: @registry_host.errors.full_messages.to_sentence
      }, status: :bad_request
    end
  rescue
    render json: { error: "Registry host not found" }, status: :not_found
  end

  private

  def check_filter_presence
    return render json: { error: "Filter parameter is required" }, status: :bad_request unless params[:filter].present?
  end

  def registry_host_params
    params.require(:registry_host).permit(:source, :destination, :status, :confidential)
  end
end
