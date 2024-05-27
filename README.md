[![View findRequiredToolboxes on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://jp.mathworks.com/matlabcentral/fileexchange/166666-findrequiredtoolboxes)

This MATLAB code defines a function `findRequiredToolboxes` which identifies the toolboxes required for a given MATLAB script or function file. The function can handle `.m`, `.mlx`, and `.slx` file types. Below is a detailed explanation of the code:

### Function Definition and Description
```matlab
function requiredToolboxes = findRequiredToolboxes(scriptPath)
```
- `findRequiredToolboxes` is the function name.
- `scriptPath` is the input argument, representing the file path of the MATLAB script or function.
- `requiredToolboxes` is the output, which will be a list of required toolboxes.

### Function Documentation
```matlab
    % findRequiredToolboxes - Identifies the toolboxes required for a given MATLAB script or function.
    %
    % Syntax: requiredToolboxes = findRequiredToolboxes(scriptPath)
    %
    % Inputs:
    %    scriptPath - The file path of the MATLAB script or function for which you want to identify required toolboxes
    %
    % Outputs:
    %    requiredToolboxes - A list of required toolboxes
```
- This section provides a brief description of the function, its syntax, inputs, and outputs.

### Input Handling
```matlab
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
```
- This section handles the input `scriptPath`.
- If no input argument is provided (`nargin == 0`), a file selection dialog (`uigetfile`) is presented to the user.
    - If the user cancels the file selection, an error message is displayed.
    - If a file is selected, its full path is constructed.
- If an input argument is provided (`nargin == 1`), `path` is set to `scriptPath`.

### Toolboxes Identification
```matlab
    % To find toolboxes
    [~,~,ext] = fileparts(path);
    if ext == ".slx"
        sList = dependencies.toolboxDependencyAnalysis(path);
        requiredToolboxes = string(sList)';
    else
        [~, pList] = matlab.codetools.requiredFilesAndProducts(path);
        Tbox = string({pList.Name}');
        Certain = cell2mat({pList.Certain}');
        requiredToolboxes = Tbox(Certain);
    end
end
```
- The function then determines the file extension of the provided file using `fileparts`.
- If the file is a Simulink model (`.slx`):
    - `dependencies.toolboxDependencyAnalysis(path)` is used to find the required toolboxes.
    - The results are converted to a string array and transposed.
- If the file is a MATLAB script or function (`.m` or `.mlx`):
    - `matlab.codetools.requiredFilesAndProducts(path)` is used to find the required files and products.
    - The product names are extracted into a string array `Tbox`.
    - Only the certain toolboxes (where the `Certain` flag is true) are included in the final list `requiredToolboxes`.

### Summary
- The function `findRequiredToolboxes` facilitates identifying the necessary toolboxes for a MATLAB script, function, or Simulink model.
- It provides flexibility by allowing the user to either input the file path directly or select it via a GUI dialog.
- It handles different file types (`.m`, `.mlx`, `.slx`) appropriately to determine the required toolboxes.
