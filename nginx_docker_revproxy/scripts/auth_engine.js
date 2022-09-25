function authorize_operation(r) {

    // storm-tape information parsing
    let get_op_info = r.variables["request_uri"];
    let method = r.variables["request_method"];
    
    let operation = (get_op_info.replace('/api/v1/', '')).split('/')[0];

    if (operation === "stage") {
        switch (method) {
            case 'DELETE':
                operation = "delete";
                break;
            case 'GET':
                operation = "get_progress";
                break;
            case 'POST':
                operation = "stage";
                break;
        }
    } else if (operation === "archiveinfo") {
        operation = (method === "POST") ? "archiveinfo" : "";
    } else {
        r.log("ERROR: UNRECOGNIZED OPERATION!");
        r.return(403);
        return;
    }

    // dati da inviare a OPA
    let opa_data = {
        "operation" : operation,
        "role" : "/" + r.headersIn["X-Role"],    // ho dovuto aggiungere lo slash siccome il token ha gruppo /dev 
        "uses_jwt" : r.headersIn["X-EnableJWT"], // quindi ora tutti i gruppi sono nella forma "/""
        "token" : r.headersIn["Authorization"]   // + nome gruppo.
    } ;
    

    // caso in cui abbiamo un certificato VOMS
    if (r.variables["voms_user"] != "") {
        opa_data["voms_user"] = r.variables["voms_user"];
        opa_data["voms_vo"] = r.variables["voms_vo"];  
    }
    
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
        
        if (!body || !body.allow) {
            r.return(403);
            return;
        }

        r.return(opa_res.status); //... che solitamente è 200. 
    });

}

export default {authorize_operation}