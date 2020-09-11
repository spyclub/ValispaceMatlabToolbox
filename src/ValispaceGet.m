function [ out_data ] = ValispaceGet(url)
% Custom GET request to the Valispace REST API
    global ValispaceLogin

    if (isempty(ValispaceLogin))
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end

    if isempty(strfind(url, 'http') ~= 1)
        url = strcat(ValispaceLogin.url, url);
    end

    out_data = webread(url, ValispaceLogin.options);
end
