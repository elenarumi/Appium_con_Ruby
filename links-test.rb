require 'appium_lib'


caps = {
  platformName: 'Mac', 
  browserName: 'Chrome'
  
}

appium_driver = Appium::Driver.new({caps: caps}, true)
driver = appium_driver.start_driver

begin

  driver.get("https://www.abc.es/")


  sleep 3

  links = driver.find_elements(:tag_name, 'a')

  puts "🔍 Se encontraron #{links.size} enlaces en la página."

  links.each_with_index do |link, index|
    begin
      url = link.attribute('href')
      if url && url.start_with?('http')
        puts "➡️ Abriendo enlace #{index + 1}: #{url}"
        driver.get(url)
        sleep 2
        driver.navigate.back 
        sleep 2
      end
    rescue StandardError => e
      puts "❌ Error al abrir enlace #{index + 1}: #{e.message}"
    end
  end

  puts "✅ Prueba completada con éxito"

rescue StandardError => e
  puts "❌ Error: #{e.message}"
ensure
  driver.quit
end
