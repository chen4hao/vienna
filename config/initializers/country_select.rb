CountrySelect::FORMATS[:with_alpha2] = lambda do |country|
  name = country.alpha2 == "TW" ? "台灣" : country.name
  "#{name} (#{country.alpha2})"
end
