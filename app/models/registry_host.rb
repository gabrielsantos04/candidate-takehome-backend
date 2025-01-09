class RegistryHost < ApplicationRecord

  validates :source, :destination, :status, presence: true
  validates :confidential, inclusion: { in: [true, false] }
  validates :status,
            inclusion: { in: %w[active inactive scheduled], message: "Invalid (active, inactive, scheduled)" }
end
