Rails.application.config.thruster.config do |config|
  # Povoliť obsluhu statických súborov
  config.static_enable = true
  
  # Nastaviť cache hlavičky pre statické súbory
  config.static_cache_control = "public, max-age=3600"
  
  # Povoliť kompresiu statických súborov
  config.gzip_enable = true
  
  # Nastaviť MIME typy, ktoré sa majú komprimovať (vrátane CSS)
  config.gzip_mime_types = %w[text/css text/html application/javascript]
end 