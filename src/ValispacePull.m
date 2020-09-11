function [ ValiListOut, ValiMatrixListOut ] = ValispacePull()
%ValispaceAllValis Returns a list of all Valis and stores it globally
    global ValispaceLogin;
    global ValiList;
    global ValiMatrixList;
    
    cachefile = 'ValispacePullCache.mat';
    
    if (isempty(ValispaceLogin) && ~isfile(cachefile))
        error(['VALISPACE-ERROR: You first have to run ValispaceInit() '...
            'or have a offline ' cachefile ' file.']);
    elseif (isempty(ValispaceLogin) && isfile(cachefile))
        load(cachefile, 'ValiList', 'ValiMatrixList');
    else
        options = ValispaceLogin.options;
        
        url = strcat(ValispaceLogin.url, 'valis/');
        ValiList = rot90(webread(url,options));
        
        url2 = strcat(ValispaceLogin.url, 'matrices/');
        ValiMatrixList = rot90(webread(url2,options));
        
        save(cachefile, 'ValiList', 'ValiMatrixList'); 
    end
    
    ValiListOut = ValiList;
    ValiMatrixListOut = ValiMatrixList;
end