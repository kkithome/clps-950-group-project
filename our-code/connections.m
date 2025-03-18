
function connections()
    % Define categories and words
    categories.Fruits = {'Apple', 'Banana', 'Orange', 'Grapes'}; %category 1: fruit options 
    categories.Animals = {'Dog', 'Cat', 'Elephant', 'Lion'}; %category 2: animal options
    categories.Colors = {'Red', 'Blue', 'Green', 'Yellow'}; % category 3: color options
    categories.Countries = {'USA', 'Canada', 'France', 'Japan'}; % category 4: countries options
    

    % Combine all words and shuffle
    allWords = [categories.Fruits, categories.Animals, categories.Colors, categories.Countries]; 
    shuffledWords = allWords(randperm(length(allWords)));

    % Reshape into a 4x4 matrix for display
    shuffledWords = reshape(shuffledWords, 4, 4)';


    % figure fot the welcome page
    fig1 = uifigure('Name', 'Welcome Page', 'Position', [100, 100, 600, 600]);

    % Added text to the welcome page
    welcomeText = uilabel(fig1, ...
        'Text', 'Welcome to Category Connections! Click the button below to Start the Game.' , ...
        'Position', [50, 550, 500, 50], ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16); 

    % Create the GUI figure
    fig2 = uifigure('Name', 'Category Connections', 'Position', [100, 100, 600, 600], 'Visible', 'off');
    figure(fig1); % puts the welcome page into focus when the game is initialized

    % closes the welcome page and makes the grid visible
    function startGame(~, ~)
        fig1.Visible = 'off';
        fig2.Visible = 'on';
    end

    % creates the start button and when clicked switches from the welcome page to the grid
    startButton = uibutton(fig1, 'push', ...
        'Text', 'Click to Play!', ...
        'Position', [250, 200, 100, 30], ...
        'ButtonPushedFcn', @startGame);

    % Create a grid layout for the words
    grid = uigridlayout(fig2, [4, 4]);
    grid.RowHeight = {'5x', '5x', '5x', '5x'};
    grid.ColumnWidth = {'5x', '5x', '5x', '5x'};

    function wordButtonPushed(btn)
        if ismember(btn.Text, selectedWords) % checks to see if the word has been selected already
            selectedWords(strcmp(selectedWords, btn.Text)) = [];
            btn.BackgroundColor = [0.94, 0.94, 0.94];
        elseif numel(selectedWords) < 4
            selectedWords{end+1} = btn.Text; % if less than four words are selected than the selected word is added to the Selected Word
            btn.BackgroundColor = [0.6, 0.8, 1]; % when added the word is higlighted in blue
        end
    end

    % Add buttons for each word in the grid
    for row = 1:4
        for col = 1:4
            % Create a button for each word
            wordButton = uibutton(grid, 'push', ...
                'Text', shuffledWords{row, col}, ...
                'ButtonPushedFcn', @(btn, ~) wordButtonPushed(btn));
            wordButton.Layout.Row = row;
            wordButton.Layout.Column = col;
        end
    end

    % When a word is selected, the game should:
        % if less than four words are selected:
            % Highlight the box
            % add the word to an going list
        % if four words are already selected:
            % tells the user that four words

    selectedWords = {};

    




    % Add a "Close" button
    closeButton = uibutton(fig2, 'push', ...
        'Text', 'Close', ...
        'Position', [250, 0, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) close(fig2));





    % End the function
    end