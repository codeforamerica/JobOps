class SearchIndeed

  def indeed_client
    Indeed.key = ENV['INDEED']
    Indeed
  end

end
