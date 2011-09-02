class ApplicationController < ActionController::Base
	# Hardware IDs sent by devices
	#
	HARDWARE = [nil, nil, nil, :v1, :v2, :book, :mirror, :daldal, :ztamp, :nanoztag, :otherRFID ]

  protect_from_forgery
end
