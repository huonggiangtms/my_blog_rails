# app/jobs/complex_calculation_job.rb
class ComplexCalculationJob < ApplicationJob
  queue_as :critical

  retry_on StandardError, wait: :exponentially_longer, attempts: 5
  discard_on ActiveRecord::RecordNotFound

  around_perform :around_calculation

  def perform(id)
    post = Post.find(id)
    # result = calculate_complex_data(report)
    # update_report(report, result)
    p "post: #{post.inspect}"
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