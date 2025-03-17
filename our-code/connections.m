
function category_connections_gui()
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

    % Display the shuffled words
    disp('Shuffled Words (4x4 Grid):');
    disp(shuffledWords);

    % Create the GUI figure
    fig = uifigure('Name', 'Category Connections', 'Position', [100, 100, 600, 600]);

    % Create a grid layout for the words
    grid = uigridlayout(fig, [4, 4]);
    grid.RowHeight = {'1x', '1x', '1x', '1x'};
    grid.ColumnWidth = {'1x', '1x', '1x', '1x'};

    selectedButtons = false(4, 4); % try to add to submit branch to see if works 

    % Add buttons for each word in the grid
    for row = 1:4
        for col = 1:4
            % Create a button for each word
            wordButton = uibutton(grid, 'push', ...
                'Text', shuffledWords{row, col}, ...
                'ButtonPushedFcn', @(btn, event) wordButtonPushed(app, btn));
            wordButton.Layout.Row = row;
            wordButton.Layout.Column = col;
        end
    end

     % Function to toggle button selection   % tried adding to submit branch to test
     function toggleSelection(btn, row, col)
        % Toggle the selection state
        selectedButtons(row, col) = ~selectedButtons(row, col); 
        % Change the button appearance based on selection
            if selectedButtons(row, col)
            btn.BackgroundColor = [0.8, 0.8, 1]; % Light blue for selected
            else
            btn.BackgroundColor = [0.94, 0.94, 0.94]; % Default gray for unselected
            end
        end  
        %end where shayla was trying to use submit branch to mess w it 

   % Add a "Submit" button       % tried adding to submit branch to test
   submitButton = uibutton(fig, 'push', ...
    'Text', 'Submit', ...
    'Position', [400, 50, 100, 30], ...
    'ButtonPushedFcn', @(btn, event) evaluateGroups());

    % Add a "Close" button
    closeButton = uibutton(fig, 'push', ...
        'Text', 'Close', ...
        'Position', [250, 50, 100, 30], ... %chooses the position,[x, y, width, height] 
        'ButtonPushedFcn', @(btn, event) close(fig));

   

    % Wait for the figure to close
    uiwait(fig);

    % End the function
    end