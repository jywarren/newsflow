# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  after_filter :import_googlenews
  
  def import_googlenews
    begin
      Newsflow.run_import
    rescue
      puts "Newsflow import failed... you may be offline"
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
