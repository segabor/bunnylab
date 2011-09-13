require 'constants'

class RabbitEventsController < ApplicationController
	before_filter :init_params
	
	
	def init_params
		@state = params[:st]	# STATE
		@sendData = params[:sd] # SENDDATA
		
		# Frame parameters
		@frameSend = from_hex( params[:ts] ) # tramesend, HEX coded
		@frameCurrent = from_hex( params[:tc] ) # tramecurrent, optional, HEX coded
		@frameNext = from_hex( params[:tn] ) # tramenext, optional, HEX coded


		# Hardware model 4 == V2 model
		@hardware = params[:h]

		# Rabbit Serial Number
		@serial = params[:sn]
		# Firmware version? ('65808')
		@version = params[:t]
		
		logger.debug "User Agent: #{request.user_agent} == MTL ? #{'MTL' == request.user_agent}"
	end


	# Ping action
	# Sample call: /vl/p4.jsp?sn=0019db9e9291&v=65808&st=1&sd=0&tc=0&h=4
	def ping
		# MAC address / serial
		logger.debug("PING called")

		render_event
	end
	
	# Button pushed, incoming audio event
	def record
		
		@command = params[:m]
		
		logger.debug("RECORD called")

		# Write audio to temp file
		File.open("/Users/segabor/Desktop/audio.wav", 'wb') do |handle|
			handle.write(request.raw_post)
		end

		render_event
	end


	# On RFID event
	# Sample: /vl/p4.jsp?sn=0019db9e9291&v=65808&st=1&sd=0&tc=0&h=4
	def rfid
		# RFID of Nano:ztag (rfid)
		@tag = params[:t]

		logger.debug("RFID called")

		render_event
	end


	# Parse hexadecimal number
	#
	# @param str Number in hexadecimal format
	# @param defValue Default integer value (optional)
	#
	def from_hex(str, defValue = 0)
		str ? str.to_i(16) : defValue
	end
	private :from_hex



	def render_event
		out = []
		out << 0x7f # HEADER

		# Kill ID Frame
		out += [0x06, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00]
		
		# Timeout Frame
		out += [0x03, 0x00, 0x00, 0x00, 0x01, 0x06]
		
		out << 0xff # FOOTER
		
		render :text => out.pack('C*'), :content_type => "application/octet-stream"
	end
	
	private :render_event
end
