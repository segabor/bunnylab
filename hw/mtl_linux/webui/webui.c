#include <string.h>

#include "mongoose.h"


/**
 * Handles request came from web client
 */
void *handleWebRequest(enum mg_event event, struct mg_connection *conn, const struct mg_request_info *request_info)
{
	// do something, get some info from bunny
	if (event == MG_NEW_REQUEST) {
		if (!strncmp("/lib/", request_info->uri, 5)) {
			// Let files put in lib handle by Mongoose
			return NULL;
		} else if (!strcmp("/", request_info->uri)) {
			// 
			// Echo requested URI back to the client
			mg_printf(conn, "HTTP/1.1 200 OK\r\n"
				"Content-Type: text/html\r\n\r\n"
				"<!DOCTYPE html>\r\n"
				"<html>\r\n"
				"<head>\r\n"
				"  <title>Bunnylab</title>\r\n"
				"  <meta charset=\"utf-8\">\r\n"
				"  <script src=\"/lib/prototype.js\"></script>\r\n"
				"  <script src=\"/lib/scriptaculous.js\"></script>\r\n"
				"</head>\r\n"
				"<body>\r\n"
				"</body>\r\n"
				"</html>\r\n"
				""
			);

			return (void *)"";  // Mark as processed
		}

	} else {
		return NULL;
	}
}
