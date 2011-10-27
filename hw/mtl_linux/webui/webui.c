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
		  mg_printf(conn, "HTTP/1.1 302 Found\r\n"
		      "Set-Cookie: original_url=%s\r\n"
		      "Location: /index.html\r\n\r\n",
		      request_info->uri);
			return "";
		} else if (!strcmp("/index.html", request_info->uri)) {
			return NULL;
		}
	} else {
		return NULL;
	}
}
