function [ out_data ] = ValispacePost(url, data)
% Custom POST request to the Valispace REST API
    global ValispaceLogin

    if (isempty(ValispaceLogin))
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end

    options = ValispaceLogin.options;

    options.RequestMethod = 'POST';
    options.MediaType = 'application/json';

    if isempty(strfind(url, 'http') ~= 1)
        url = strcat(ValispaceLogin.url, url);
    end

    out_data = webwrite(url, data, options);
end
