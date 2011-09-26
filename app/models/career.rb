class Career < ActiveRecord::Base

  has_many :career_users
  has_many :users, :through => :career_users

  def futures_pipeline
    futures_client
  end

  protected

  def futures_client
    futures_client ||= FuturesPipeline::Client.new
  end

end
