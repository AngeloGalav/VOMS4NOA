function authorize_operation(r) {

    // dati da inviare a OPA
    let opa_data = {
        "operation" : r.headersIn["X-Operation"],
        "role" : "/" + r.headersIn["X-Role"],    // ho dovuto aggiungere lo slash siccome il token ha gruppo /dev 
        "uses_jwt" : r.headersIn["X-EnableJWT"], // quindi ora tutti i gruppi sono nella forma "/""
        "token" : r.headersIn["Authorization"]   // + nome gruppo.
    } ;
    

    // caso in cui abbiamo un certificato VOMS
    if (r.variables["voms_user"] != "") {
        opa_data["voms_user"] = r.variables["voms_user"]; 
    }
    
    r.log("[DEBUG REVPROXY]: DATA IS " +  opa_data["voms_user"]);

    // pacchetto HTTP da inviare ad
    var opts = {
        method: "POST",
        body: JSON.stringify(opa_data)
    };
    
    // gestisce la risposta di OPA
    r.subrequest("/_opa", opts, function(opa_res) {
        r.log("OPA Responded with status " + opa_res.status);
        r.log(JSON.stringify(opa_res));

        var body = JSON.parse(opa_res.responseText);
        
        if (!body) {
            r.return(403);
            return;
        }

        if (!body.allow) {
            r.return(403);
            return;
        }

        r.return(opa_res.status);
    });

}

export default {authorize_operation}