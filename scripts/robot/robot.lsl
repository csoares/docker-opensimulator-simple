integer i = 0;
integer base_channel = 900;
float X = 0.0;
float Y = 0.0;
float Z = 0.0;
vector position;
float move = 0.5;
integer rot = 0;

string http_host = "192.168.1.65";
string m = "12";
integer t = 1000;

key http_request_robot;

turn(integer angle) {
    vector eul = < 0, 0, angle > ; // Rotate around z-axis (Euler)
    eul *= DEG_TO_RAD; //convert to radians
    rotation quat = llEuler2Rot(eul); //convert to quaternion
    llSetRot(quat); //rotate the object
}
default {
    state_entry() {
        llSay(0, "Farrusco " + i + " prim listen channel " + (base_channel + i));
        llListen(base_channel + i, "", NULL_KEY, "");
    }
    // Escutar comandos emitidos
    listen(integer channel, string name, key id, string message) {
        vector position = llGetPos();
        X = position.x;
        Y = position.y;
        Z = position.z;
        llSay(0, "I heard " + name + " say: " + message);
        if (message == "12") {
            X = X + move;
        } else if (message == "6") {
            X = X - move;
        } else if (message == "3") {
            //Y=Y-move;  
            rot -= 45;
            turn(rot);
        } else if (message == "9") {
            //Y=Y+move;
            rot += 45;
            turn(rot);
        }
        llSetPos( < X, Y, Z > );
        if (name != "Totem") {
            http_request_robot = llHTTPRequest("http://" + http_host + ":8888/sendFarrusco.html?i=" + i + "&m=" + m + "&t=" + t, [HTTP_METHOD, "GET"], "");
        }
    }

    // EVENT: http_response - triggered when script receives HTTP response to an HTTP request
    http_response(key http_request_id, integer status, list metadata, string body) {
        if (http_request_robot == http_request_id) {
            llSetText("Forward", < 0, 0, 1 > , 1);
            llSay(0, "Http Response: " + body);
            // After sending Move to Farrusco, move SL Farrusco accordingly
            llSay(base_channel + i, m);
        }
    }

}