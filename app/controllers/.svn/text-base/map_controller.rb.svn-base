class MapController < ApplicationController

  def index
    render :layout => 'index'
  end

  def source
    @source_name = params[:id].gsub(/_/,'.')
    @source = Source.find_by_name(@source_name)
    render :layout => 'index'
  end

  def place
    @title = params[:id].gsub(/_/,'.')
    @place = @title
    render :layout => 'index'
  end
  
end
