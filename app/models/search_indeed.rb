class SearchIndeed

  def indeed_client
    indeed
  end

  protected

  def indeed
    Indeed.key = ENV['INDEED']
    @client ||= Indeed.new
  end
end
