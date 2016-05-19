class HomeController < ApplicationController

  def welcome

  end

  def manhattan
    manhattanPolys = File.read('app/assets/geojson/36061.geojson')
    render :json => manhattanPolys
  end

  def queens
    queensPolys = File.read('app/assets/geojson/36081.geojson')
    render :json => queensPolys
  end

  def bronx
    bronxPolys = File.read('app/assets/geojson/36005.geojson')
    render :json => bronxPolys
  end

  def brooklyn
    brooklynPolys = File.read('app/assets/geojson/36047.geojson')
    render :json => brooklynPolys
  end

  def statenisland
    statenislandPolys = File.read('app/assets/geojson/36085.geojson')
    render :json => statenislandPolys
  end


  def markers
    markers = File.read('app/assets/geojson/marker_hash.geojson').to_json
    render :json => markers
  end


end
