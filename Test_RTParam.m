clear
close all force

%% A. Create input and output objects
fileReader = dsp.AudioFileReader(...
    'speech_dft.mp3',...
    'SamplesPerFrame', 64,...
    'PlayCount', 3);

deviceWriter = audioDeviceWriter(...
    'SampleRate', fileReader.SampleRate);

%% B. Create an object of a handle class
x = parameterRef;
x.name = 'gain';
x.value = 2.5;

%% C. open the UI function for your parameter
parameterTuningUI(x, 0, 5);

%% D. Process audio in a loop
while ~isDone(fileReader)
    audioIn = fileReader();
    disp(x.value)
    drawnow limitrate
    audioOut = audioIn.*x.value;
    
    deviceWriter(audioOut);
end

%% Release input and output objects
release(fileReader)
release(deviceWriter)

function parameterTuningUI(parameter, parameterMin, parameterMax)

% Map slider position to specified range
rangeVector = linspace(parameterMin, parameterMax,1001);
[~, idx] = min(abs(rangeVector-parameter.value));
initialSliderPosition = idx/1000;

% Main figure
hMainFigure = figure(...
    'Name', 'Parameter Tuning',...
    'MenuBar', 'none',...
    'ToolBar', 'none',...
    'HandleVisiBility', 'callback',...
    'NumberTitle', 'off',...
    'IntegerHandle', 'off');

    % Slider to tune parameter
    uicontrol('Parent', hMainFigure,...
        'Style', 'slider',...
        'Position', [80, 205, 400, 23],...
        'Value', initialSliderPosition,...
        'Callback', @slidercb);
    
    % Label for slider
    uicontrol('Parent', hMainFigure,...
        'Style', 'text',...
        'Position', [10, 200, 80, 23],...
        'String', parameter.name);
    
    % Display current parameter value
    paramValueDisplay = uicontrol('Parent', hMainFigure,...
        'Style', 'text',...
        'Position', [490, 205, 50, 23],...
        'BackgroundColor', 'white',...
        'String', parameter.value);
    
    % Update parameter value if slider value changed
    function slidercb(slider,~)
        val = get(slider, 'Value');
        rangeVectorIndex = round(val*1000)+1;
        parameter.value = rangeVector(rangeVectorIndex);
        set(paramValueDisplay, 'String', num2str(parameter.value));
    end
end