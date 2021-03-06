function [ id, Vali ] = ValispaceName2Id(name)
    global ValiList
    global ValiMatrixList
    
    id = 0;
    Vali = [];
    
    if (isempty(ValiList))
        error('VALISPACE-ERROR: If you use this function with a string (Vali-Name), you first need to call ValispacePull().'); 
    end
      
    for vali = ValiList
        if (strcmpi(vali.name, name) == 1)
            Vali = vali;
            id = vali.id;
        end
    end
    
    if (id == 0)
        for matri = ValiMatrixList
            if (strcmpi(matri.unique_name, name) == 1)
                Vali = matri;
                id = matri.id;
            end
        end
        if(id == 0)
            error('VALISPACE-ERROR: Vali not found')
        end
    end
end