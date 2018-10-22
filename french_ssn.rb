require 'byebug'
require "date"
require "yaml"

PATTERN = /(?<gender>[12])\s?(?<year>\d{2})\s?(?<month>(0[1-9]|1[012]))\s?(?<department>(0[1-9]|[1-9]\d|2[AB]))(\s?\d{3}){2}\s?(?<key>\d{2})/
DEPARTMENTS = YAML.load_file('./data/french_departments.yml')
# match string (ssn) against pattern
# determine genre (1 - male, 2- female)
# build year
# convert month digits into month long name


# read YAML to get departments
# fetch department with department code
# user key to validate ssn

def french_ssn_info(ssn)
  return 'The number is invalid' if ssn.empty?

  # key = data[:key]


  data = ssn.match(PATTERN)
  if ssn_is_valid?(ssn, data[:key].to_i)
    gender = data[:gender] == "1" ? "man" : "woman"
    month = Date::MONTHNAMES[data[:month].to_i]
    department = DEPARTMENTS[data[:department]]
    year = data[:year].to_i + 1900
    return "a #{gender}, born in #{month}, #{year} in #{department}."
  else
    return "The number is invalid"
  end
end

def ssn_is_valid?(ssn, key)
# (46,
# equal to the remainder of the division of
# (97 - ssn_without_key) by 97.)
  bignumber = ssn.gsub(/\s/, "")[0...-2].to_i
  key == (97 - bignumber) % 97
end




