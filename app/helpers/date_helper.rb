module DateHelper
  def check_present(check_date)
    if check_date.nil?
      value = "Present"
    else
      value = check_date
    end
  end
end
