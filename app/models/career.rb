class Career < ActiveRecord::Base

  def futures_pipeline
    futures_client
  end

  protected

  def futures_client
    futures_client ||= FuturesPipeline::Client.new
  end

end
