# coding: utf-8
require 'starling'
require 'crack'
require 'net/http'
require 'cgi'
require 'iconv'
require 'json'
class Backend
  def run
    process_queue
  end

  private
  def process_queue
    @starling = Starling.new('127.0.0.1:11211')
    th = Thread.new do
      Thread.current.abort_on_exception = true
      loop do
        item = @starling.get('backend')
        unless item.nil?
          jitem = Crack::JSON.parse(item) rescue nil

          google_api_url = "http://www.google.com/ig/api?weather=#{CGI::escape(jitem["body"])}"

          ig_weather = Crack::XML.parse(Iconv.conv('UTF-8',
          'ISO-8859-1',
          Net::HTTP.get(URI.parse(google_api_url))
          )
          ) rescue nil

          if jitem && ig_weather
            process_job(jitem,ig_weather)
          else
            puts jitem["from"]
            @starling.set('listener',
            {
              :from => jitem["from"],
              :success => false,
              :message => "An error occured while accessing Google Weather API. You may try again later"
            }.to_json) unless jitem.nil?
          end

        end
      end
    end

  end


  def process_job(jitem,ig_weather)
    if ig_weather["xml_api_reply"]["weather"]["problem_cause"]
      @starling.set('listener',{
        :from => jitem["from"],
        :success => false,
        :message => "Data not available. Try being more precise when typing your location (ex. trois-rivières, québec)"
      }.to_json)
    else      
      weather = ig_weather["xml_api_reply"]["weather"]
      data = {
        :forecast_obj => weather["forecast_conditions"],
        :city => weather["forecast_information"]["city"]["data"],
        :winds => weather["current_conditions"]["wind_condition"]["data"],
        :unit_system => weather["forecast_information"]["unit_system"]["data"],
        :temp_f => weather["current_conditions"]["temp_f"]["data"],
        :temp_c => weather["current_conditions"]["temp_c"]["data"],
      }      
      
      
      
      @starling.set('listener',
      {
        :from => jitem["from"],
        :success => true,
        :message => "Weather data for <b>#{data[:city]}:</b>",
        :details => {
          :current_temperature => "#{data[:temp_f]} ° F / #{data[:temp_c]} ° C",
          :unit => data[:unit_system],
          :winds => data[:winds],
          :today => temperatures(
                      data[:unit_system],
                      data[:forecast_obj][0]
                    ).merge(:condition => data[:forecast_obj][0]["condition"]["data"]),

          :tomorrow => temperatures(
                        data[:unit_system],
                        data[:forecast_obj][1]
                      ).merge(:condition => data[:forecast_obj][1]["condition"]["data"])
        }
      }.to_json)
    end
  end

  def temperatures(source_unit,obj)
    x = {}

    if(source_unit == "US")
      #we convert to Celcius
      x["low_c"] = obj["low"]["data"].to_i.to_celcius
      x["high_c"] = obj["high"]["data"].to_i.to_celcius
      x["low_f"] = "#{obj["low"]["data"]} ° F"
      x["high_f"] = "#{obj["high"]["data"]} ° F"

    else
      #we convert to farenheit
      x["low_f"] = obj["low"]["data"].to_i.to_farenheit
      x["high_f"] = obj["high"]["data"].to_i.to_farenheit
      x["low_c"] = "#{obj["low"]["data"]} ° C"
      x["high_c"] = "#{obj["high"]["data"]} ° C"
    end
    x
  end
end

class Fixnum
  def to_celcius
    ((self - 32) / 1.8).round.to_s + " °C"
  end

  def to_farenheit
    (self * 1.8 + 32).round.to_s + " °F"
  end
end

Backend.new.run

#Always remember to pause the main thread at the end since it does not contain any
#blocking call.
Thread.stop
