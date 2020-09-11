function ValispaceInit(URL,Username,Password,insecure)

% check for SSL connection, before sending the username and password
    if (strncmpi(URL,'http://',7))
        if (exist('insecure', 'var') && strcmp(insecure, 'insecure'))
            warning('You are sending your password-credentials using an unencrypted connection. Better use "https://..." instead!');
        else
            error('VALISPACE-ERROR: You are trying to send your password-credentials using an unencrypted connection. Better use "https://..." instead! If you still want to go ahead with an insecure connection, please use ValisapceInit() with "insecure" as a last argument.');
        end
    end


%ValispaceInit performs the password based oAuth 2.0 login for resd/write access
    if (URL(end)=='/')
        BasicUrl = URL(1:end-1);
    else
        BasicUrl = URL;
    end
    oAuthUrl = strcat(BasicUrl, '/o/token/');
    client_id = 'docs.valispace.com/user-guide/addons/#matlab'; % registered client-id in Valispace Deployment
    result = webwrite(oAuthUrl,'grant_type','password','username',Username,'password',Password,'client_id',client_id);
    
    access = horzcat('Bearer ', result.access_token);
    
    global ValispaceLogin;
    if verLessThan('matlab', '9.1')    % HeaderFields was introduced in 2016b (9.1)
        ValispaceLogin.options = weboptions('Timeout', 200, 'ContentType', 'json', 'KeyName', 'Authorization', 'KeyValue', access);
    else
        ValispaceLogin.options = weboptions('Timeout', 200, 'HeaderFields', {'Authorization' access; 'Content-Type' 'application/json'});
    end
    
    ValispaceLogin.url = strcat(BasicUrl, '/rest/'); 

    fprintf('VALISPACE: You have been successfully connected to the %s API.\n', ValispaceLogin.url);
 
end
