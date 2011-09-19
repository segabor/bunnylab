require 'constants'

class ConfigurationController < ApplicationController
		# revision number => bootcode file
		BOOTCODES = {
			0x0000eae1 => 'bootcode_1.bin',
			0x0001486b => 'bootcode_2147483647.5.bin',
			0x00018fc1 => 'bootcode_2.5.bin',
			0x00018fe6 => 'bc-nominal-h4.bin'
		}

		#
		# Send out the latest bootcode to Nabaztag
		# 
		def bootcode
			# /vl/bc.jsp?v=0.0.0.10&m=00:19:db:9e:92:91&l=00:00:00:00:00:00&p=00:00:00:00:00:00&h=4
			#
			# Firmware version, e.g.0.0.0.10
			@version = params[:v]

			# MAC address
			@serial = params[:m]

			# Hardware model 4 == V2 model
			@hardware = params[:h]


			send_file Rails.public_path+'/'+'bc-nominal-segabor.bin',
				:type => 'application/octet-stream'
		end


		#
		# Bunny requests the location of different services
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
end
