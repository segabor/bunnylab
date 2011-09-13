#
# Nabaztag Constants
#

module Bunny
	module Event
		EV_DUMMY	= 0x7fffffff
		EV_ASLEEP	= 0x7ffffffe
	end
	
	module Source
		DELETE = 0 # ("Delete Source")
		WEATHER = 1 # (1, "Meteo"),
		TRADE = 2 # (2, "Bourse"),
		TRAFFIC = 3 # (3, "Trafic"),
		LEFT_EAR = 4 # (4, "Left Ear"),
		RIGHT_EAR = 5 #(5, "Right Ear"),
		MAIL = 6 # (6, "Mail"),
		AIR = 7 # (7, "Air"),
		MESSAGE = 8 # (8, "Message"),
		TAICHI = 9 # (14, "Taichi"),
		ADVANCED_TRADE = 20 #(20, "Bourse Full");
	end

	module Mode
		ACTIVE = 0
		STANDBY = 1
		FORCE_ACTIVE = 2
		FORCE_STANDBY = 3
	end
end
