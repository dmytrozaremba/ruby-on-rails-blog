module Visible
  extend ActiveSupport::Concern

  VALID_STATUSES = %w[public private]

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  def public?
    status == 'public'
  end
end
