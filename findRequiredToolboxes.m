function reqiredToolboxes = findRequiredToolboxes(scriptPath)
    % findRequiredToolboxes - Identifies the toolboxes required for a given MATLAB script or function.
    %
    % Syntax: requiredToolboxes = findRequiredToolboxes(scriptPath)
    %
    % Inputs:
    %    scriptPath - The file path of the MATLAB script or function for which you want to identify required toolboxes
    %
    % Outputs:
    %    requiredToolboxes - A list of required toolboxes

    % You can set scriptPath with GUI or directly.
    switch nargin
        case 0
            [file,path] = uigetfile( ...
                {'*.m;*.mlx;*.slx', ...
                'MATLAB Files (*.m,*.mlx,*.slx)'; ...
                '*.*',  'All Files (*.*)'},'Select a file');
            if isequal(file,0)
                disp('User selected Cancel');
                msg = 'You need to select a file.';
                error(msg)
            else
                path = fullfile(path,file);
            end
        case 1
            path = scriptPath;
    end

    % To find toolboxes
    [~,~,ext] = fileparts(path);
    if ext == ".slx"
        sList = dependencies.toolboxDependencyAnalysis(path);
        reqiredToolboxes = string(sList)';
    else
        [~, pList] = matlab.codetools.requiredFilesAndProducts(path);
        Tbox = string({pList.Name}');
        Certain = cell2mat({pList.Certain}');
        reqiredToolboxes = Tbox(Certain);
    end
end