class SearchDirectEmployers

  def direct_client
    direct_employers_client
  end

  protected

  def direct_employers_client
    @client ||= DirectEmployers.new({:key => ENV['DIRECT_EMPLOYERS']})
  end

end

