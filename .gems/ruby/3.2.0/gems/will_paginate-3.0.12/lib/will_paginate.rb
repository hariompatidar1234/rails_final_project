  # You will paginate!
module WillPaginate
end

if defined?(Rails::Railtie)
  require 'will_paginate/railtie'
elsif defined?(Rails::Initializer)
  raise "will_paginate 3.0 is not compatible with Rails 2.3 or older"
end

if defined?(Merb::AbstractController)
  require 'will_paginate/view_helpers/merb'

  Merb::BootLoader.before_app_loads do
    adapters = { :datamapper => 'data_mapper', :activerecord => 'active_record', :sequel => 'sequel' }
    # auto-load the right ORM adapter
    if adapter = adapters[Merb.orm]
      require "will_paginate/#{adapter}"
    end
  end
end

if defined?(Sinatra) and Sinatra.respond_to? :register
  require 'will_paginate/view_helpers/sinatra'
end

Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end


if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per(value = nil) per_page(value) end
        def total_count() count end
      end
    end
    module CollectionMethods
      alias_method :num_pages, :total_pages
    end
  end
end
