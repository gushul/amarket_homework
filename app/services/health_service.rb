# frozen_string_literal: true

class HealthService
  OK_STATUS = :ok
  FAIL_STATUS = :internal_server_error

  def status
    return FAIL_STATUS unless database_connected?

    OK_STATUS
  end

  def database_connected?
    ApplicationRecord.connection.select_value('SELECT 1') == 1
  rescue StandardError
    false
  end
end
