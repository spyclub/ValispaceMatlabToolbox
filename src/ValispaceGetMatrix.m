function [ Matrix, MatrixNames, MatrixValiIDs ] = ValispaceGetMatrix(name_or_id)
% ValispaceGetMatrix() returns a Matlab Matrix with the values, one with
% the names and one with the ValiIDs
    global ValispaceLogin
    global ValiList
    
    if (isempty(ValispaceLogin)) 
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end
    
    % use name instead of ID
    if (isa(name_or_id, 'string') || isa(name_or_id, 'char'))
        name_or_id = ValispaceName2Id(name_or_id);
    end

    url = strcat(ValispaceLogin.url, 'matrices/', num2str(name_or_id), '/');
    MatrixData = webread(url, ValispaceLogin.options);
    
    rows = MatrixData.number_of_rows;
    columns = MatrixData.number_of_columns;
    
    Matrix = zeros(rows, columns);
    MatrixValiIDs = zeros(rows, columns);
    
    % create empty string array
    MatrixNames = string([]);
    
    for column = 1:columns
       for row = 1:rows
           Vali = ValispaceGetVali(MatrixData.cells(row,column));
           Matrix(row,column) = Vali.value;
           MatrixNames(row,column) = Vali.name;
           MatrixValiIDs(row,column) = Vali.id;
       end
    end
    
end