# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
#Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( orders.css )
Rails.application.config.assets.precompile += %w( content.css )
Rails.application.config.assets.precompile += %w( component.css )
Rails.application.config.assets.precompile += %w(style.css)
Rails.application.config.assets.precompile += %w( classie.js )
Rails.application.config.assets.precompile += %w( cuisines.js )
Rails.application.config.assets.precompile += %w( menuStyle.css )
Rails.application.config.assets.precompile += %w( basic.js )
Rails.application.config.assets.precompile += %w( basic1.js )
Rails.application.config.assets.precompile += %w( basic2.js )
Rails.application.config.assets.precompile += %w( basic.css )
