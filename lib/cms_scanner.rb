# Gems
require 'opt_parse_validator'
require 'typhoeus'
require 'nokogiri'
require 'active_support/inflector'
require 'addressable/uri'
# Standard Libs
require 'pathname'
require 'erb'
# Custom Libs
require 'helper'
require 'cms_scanner/target'
require 'cms_scanner/browser'
require 'cms_scanner/version'
require 'cms_scanner/controllers'
require 'cms_scanner/formatters'

# Module
module CMSScanner
  # Scan
  class Scan
    def initialize
      controllers << Controller::Core.new
    end

    def controllers
      @controllers ||= Controllers.new
    end

    def run
      begin
        controllers.run
      rescue => e
        controllers.first.formatter.output('scan_aborted', reason: e.message)
      ensure
        controllers.first.formatter.beautify
      end
    end
  end
end