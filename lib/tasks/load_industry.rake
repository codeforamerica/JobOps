require 'csv'

desc "Load IndustryLookup table"
task :industry => :environment do
  puts "Accomidation and Food Services"
  load_csv("Accommodation_and_Food_Services.csv", 1)

  puts "Administrative and Support Services"
  load_csv("Administrative_and_Support_Services.csv", 2)

  puts "Agriculture Forestry Fishing and Hunting"
  load_csv("Agriculture_Forestry_Fishing_and_Hunting.csv", 3)

  puts "Arts and Entertainment and Recreation"
  load_csv("Arts_Entertainment_and_Recreation.csv", 4)

  puts "Construciton"
  load_csv("Construction.csv", 5)

  puts "Educational Services"
  load_csv("Educational_Services.csv", 6)

  puts "Finance and Insurance"
  load_csv("Finance_and_Insurance.csv", 7)

  puts "Government"
  load_csv("Government.csv", 8)

  puts "Health Care and Social Assistance"
  load_csv("Health_Care_and_Social_Assistance.csv", 9)

  puts "Information"
  load_csv("Information.csv", 10)

  puts "Management of Companies and Enterprises"
  load_csv("Management_of_Companies_and_Enterprises.csv", 11)

  puts "Manufacturing"
  load_csv("Manufacturing.csv", 12)

  puts "Mining and Quarrying"
  load_csv("Mining_Quarrying_and_Oil_and_Gas_Extraction.csv", 13)

  puts "Other Services"
  load_csv("Other_Services_Except_Public_Administration_.csv", 14)

  puts "Professional Services"
  load_csv("Professional_Scientific_and_Technical_Services.csv", 15)

  puts "Real Estate"
  load_csv("Real_Estate_and_Rental_and_Leasing.csv", 16)

  puts "Retail Trade"
  load_csv("Retail_Trade.csv", 17)

  puts "Self Employed"
  load_csv("Self-Employed.csv", 18)

  puts "Transporation"
  load_csv("Transportation_and_Warehousing.csv", 19)

  puts "Utilities"
  load_csv("Utilities.csv", 20)

  puts "Wholesale Trade"
  load_csv("Wholesale_Trade.csv", 21)

end

def load_csv(file, industry)
  CSV.foreach("data/industry/#{file}", {:headers => true}) do |row|
      if row[1].present?
        IndustryLookup.create(:industry_id => industry, :onet_code => row[1], :api_safe_onet_code => row[1].tr('.','-'), :occupation => row[2])
      end
  end
end
