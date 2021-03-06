require 'constants'

class BeforeChristController < ApplicationController
	# This is the first call from a bunny
	# 
	def index
		# /vl/bc.jsp?v=0.0.0.10&m=00:19:db:9e:92:91&l=00:00:00:00:00:00&p=00:00:00:00:00:00&h=4
		#
		# TODO: Handle it better way
		
		# Firmware version, e.g.0.0.0.10
		@version = params[:v]
		# MAC address
		@serial = params[:m]
		# Hardware model 4 == V2 model
		@hardware = params[:h]

		send_file Rails.public_path+'/bootcode_2.5.bin', :type => 'application/octet-stream'
	end



	# Used in the locate.jsp, ping shows where and when to broadcast.
	# It also serves as the V2 that has been a contact platform Page
	# used just for the mirrors and v2
	#
	def locate
		# Object version, e.g. 18673 (BC version)
		@version = params[:v]
		# MAC address / serial
		@serial = params[:sn]
		# Hardware model 4 == V2 model
		@hardware = params[:h]

		if (HARDWARE[@hardware.to_i] == :v2)
			resp = <<__TEXT
ping #{Rails.configuration.zone_ping}
broad #{Rails.configuration.broad}
xmpp_domain #{Rails.configuration.xmpp}
__TEXT
			
			render :text => resp
		else
			# FIXME
			render :text => ""
		end
	end
	
	
	# /vl/sendMailXMPP.jsp?m=0019db9e9291&d=almacska&r=FailureRegister2&v=18673
	# MOCK
	def sendMailXMPP
		# FIXME: unimplemented
		@serial = params[:m]
		@host = params[:d]
		@msg = params[:r]
		@version = params[:v]

		render :text => ""
	end
end
