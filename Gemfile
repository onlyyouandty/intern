source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


#in order for heroku to work, postgres must be used instead of sqlite3. heroku uses its own database.yml
#heroku also needs to be told to use ruby 1.9.3
#ruby "1.9.3"
#gem 'pg'



# Gems used only for assets and not required
# in production environments by default.

  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'coffee-script-source', '~> 1.4.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'


# For JQuery
gem 'jquery-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Authentication
gem 'devise', '2.2'
gem 'devise-encryptable'

# Admin
gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'

#For Qsort
gem 'acts_as_list'

#For uploading files
gem 'carrierwave'

# To use Jbuilder templates for JSON
gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# For Foundation
gem 'foundation-rails'

# For Paperclip
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
gem "paperclip-dropbox", ">= 1.1.7"
gem 'compass-rails'


source 'https://rubygems.org'
ruby "2.1.3"



# Use Uglifier as compressor for JavaScript assets
gem 'turbolinks'


gem 'autoprefixer-rails'

gem 'railties'

gem 'figaro'

group :development do
	gem 'sqlite3'
end

group :production do
	# gem 'pg'
	gem 'rails_12factor'
end
