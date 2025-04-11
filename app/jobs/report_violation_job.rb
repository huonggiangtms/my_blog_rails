class ReportViolationJob < ApplicationJob
  queue_as :critical

  # Đổi từ `:exponentially_longer` sang độ trễ cố định
  retry_on StandardError, wait: 5.seconds, attempts: 5
  discard_on ActiveRecord::RecordNotFound

  around_perform :around_calculation

  def perform(user, post) 
    Rails.logger.info "Sending violation email to #{user.email}"

    UserMailer.report_violation_email(user, post).deliver_now
  end

  private

  def around_calculation
    ActiveRecord::Base.transaction do
      yield
    end
  rescue => e
    Rails.logger.error("Calculation failed: #{e.message}")
    raise
  end
end