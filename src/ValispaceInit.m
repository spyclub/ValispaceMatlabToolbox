function ValispaceInit(URL, Username, Password, insecure)
% Initialise Valispace and connect to API

% check for SSL connection, before sending the username and password
    if (strncmpi(URL,'http://',7))
        passwordWarning = ['Sending password-credentials ' ...
            'using an unencrypted connection. '...
            'Better to use "https://..." instead!'];
            
        if (exist('insecure', 'var') && strcmp(insecure, 'insecure'))
            warning(['VALISPACE-WARNING: ' passwordWarning]);
        else
            error(['VALISPACE-ERROR: ' passwordWarning ...
                ' To still use insecure connection, use ValisapceInit ' ...
                'with "insecure" as the last argument.']);
        end
    end

%Perform password based oAuth 2.0 login for read/write access
    if (URL(end)=='/')
        BasicUrl = URL(1:end-1);
    else
        BasicUrl = URL;
    end
    oAuthUrl = strcat(BasicUrl, '/o/token/');
    % registered client-id in Valispace Deployment
    client_id = 'docs.valispace.com/user-guide/addons/#matlab'; 
    result = webwrite(oAuthUrl, ...
        'grant_type', 'password', ...
        'username', Username, ...
        'password', Password, ...
        'client_id', client_id);
    
    access = horzcat('Bearer ', result.access_token);
    
    global ValispaceLogin;
    % HeaderFields was introduced in 2016b (9.1)
    if verLessThan('matlab', '9.1')
        ValispaceLogin.options = weboptions('Timeout', 200, ...
            'ContentType', 'json', ...
            'KeyName', 'Authorization', ...
            'KeyValue', access);
    else
        ValispaceLogin.options = weboptions('Timeout', 200, ...
            'HeaderFields', ...
            {'Authorization' access; ...
            'Content-Type' 'application/json'});
    end
    
    ValispaceLogin.url = strcat(BasicUrl, '/rest/'); 

    fprintf('VALISPACE: Successfully connected to the %s API.\n', ...
        ValispaceLogin.url);
end
