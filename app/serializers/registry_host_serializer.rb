class RegistryHostSerializer < ActiveModel::Serializer
  attributes :id, :source, :destination, :status, :confidential, :created_at, :updated_at

  def destination
    object.confidential ? "-" : object.destination
  end

  def status
    object.confidential ? "-" : object.status
  end

  def updated_at
    object.confidential ? "-" : object.updated_at.to_s
  end

  def created_at
    object.created_at.to_s
  end
end
