string http_host = "192.168.1.65";
string i = "1";
string m = "12";
string granted_url = "";

key url_request;
key http_request_id;


float X = 0.0;
float Y = 0.0;
float Z = 0.0;

float move = 0.5;




default {
    // EVENT: state_entry - triggered on any state transition and startup. 
    state_entry() {
        // Each time prim is activated new URL is requested, but old one NOT RELEASED!
        // Hence, be careful and release it (before request a new one) since URLs are limited!
        url_request = llRequestURL();

    }
    // EVENT: http_request - triggered when the script receives an HTTP request.
    http_request(key id, string method, string body) {
        if (id == url_request) {
            if (method == URL_REQUEST_DENIED)
                llOwnerSay("The following error occurred while attempting to get a free URL for this device:\n \n" + body);

            else if (method == URL_REQUEST_GRANTED) {
                granted_url = body;
                llLoadURL(llGetOwner(), "Click to visit my URL!", granted_url);
            }
        } else {
            llSay(0, "Farrusco" + i + "received a request method = " + method + " body " + body);
            // do here the code to send to the robot
            string channel = llJsonGetValue(body, ["channel"]);
            string message = llJsonGetValue(body, ["message"]);

            llSay((integer) channel, message);
            llHTTPResponse(id, 200, "Farrusco received request parameters ");
        }

    }

}