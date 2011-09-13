

module Bunny
	module Message
		
		# Serialize Ping
		module Serializer
			HEADER = 0x7f
			FOOTER = 0xff

			# @param priority (number)
			# @param firmware (string)

			# priority = 1 : bytecode+kill+timeout+src+status+fin
			# priority != 1: src+status+bytecode+kill+timeout+fin
			def self.ping(priority, firmware)
				bytes = []
				
				bytes << HEADER
				if priority == 1
					
				else
				end

				
				bytes << FOOTER

				bytes
			end

			

			def self.to_bytecode(outStream, message, eventID, priority, hw)
			end
		end
	end
end