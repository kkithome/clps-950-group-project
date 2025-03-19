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


    % figure fot the welcome page
    fig1 = uifigure('Name', 'Welcome Page', 'Position', [100, 100, 600, 600]);

    % Added text to the welcome page
    uilabel(fig1, ...
        'Text', ['Welcome to Category Connections! Click the button below to Start the Game. ' ...
        'The goal is to group four similar words together into one category!   ' ...
        'Created by Kaluki, Selam, and Shayla'], ...
        'Position', [50, 500, 500, 80], ...  % Increase height to 80 for better text wrapping
        'HorizontalAlignment', 'center', ...
        'FontSize', 16, ...
        'WordWrap', 'on'); 

    % Create the GUI figure
    fig2 = uifigure('Name', 'Category Connections', 'Position', [100, 100, 600, 700], 'Visible', 'off');

    % creates the start button and when clicked switches from the welcome page to the grid
    uibutton(fig1, 'push', ...
        'Text', 'Click to Play!', ...
        'Position', [250, 200, 100, 30], ...
        'ButtonPushedFcn', @startGame);

    function displayGrid()
        delete(grid.Children);
        for row = 1:4
            for col = 1:4
                wordButton = uibutton(grid, 'push', ...
                'Text', shuffledWords{row, col}, ...
                'ButtonPushedFcn', @(btn, ~) wordButtonPushed(btn));
                wordButton.Layout.Row = row;
                wordButton.Layout.Column = col;
            end
        end
    end


    function shuffleWords()
        shuffledWords = allWords(randperm(length(allWords)));
        shuffledWords = reshape(shuffledWords, 4, 4);
        displayGrid();
    end


    % Create a grid layout for the words
    grid = uigridlayout(fig2, [4, 4]);
    grid.RowHeight = {'4x', '4x', '4x', '4x'};
    grid.ColumnWidth = {'5x', '5x', '5x', '5x'};

    % figure fot the toggle/ category choose page
    fig3 = uifigure('Name', 'Correct! Select a catgory', 'Position', [100, 100, 600, 600], 'Visible', 'off');

    % figure for if the connection is incorret
    fig4 = uifigure('Name', 'Incorrect', 'Position', [100, 100, 600, 600], 'Visible', 'off');

    uilabel(fig4, ...
        'Text', 'Sorry, try again.' , ...
        'Position', [50, 550, 500, 50], ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16); 
    % add text to incorrect page: 

    % Added text to the welcome page
    uilabel(fig3, ...
        'Text', 'Correct! Select a category from the drop down!' , ...
        'Position', [50, 550, 500, 50], ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16); 
        % closes the grid and then show the toggle/ category choosing slide
    

    figure(fig1); % puts the welcome page into focus when the game is initialized
    selectedWords = {};

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



    % Add a "Close" button
    uibutton(fig2, 'push', ...
        'Text', 'Close', ...
        'Position', [350, 0, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) close(fig2));

    uibutton(fig2, 'push', ...
        'Text', 'Submit', ...
        'Position', [250, 0, 100, 30], ...
        'ButtonPushedFcn', @submit);  
        'Visible'; 'off'; % Start hidden;
    
    uibutton(fig2, 'push', ...
        'Text', 'Shuffle Words',...
        'Position', [150, 0, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) shuffleWords());

     s1 = uistyle("BackgroundColor", "#ffec33"); %yellow
     s2 = uistyle("BackgroundColor", "#8adc75"); % green
     s3 = uistyle("BackgroundColor", "#75a9dc"); % blue
     s4 = uistyle("BackgroundColor", "#ac75dc"); 

    function dropdownFunctionality()
        dropdownItems = {'Fruits', 'Animals', 'Colors', 'Countries'}
        dd = uidropdown(fig3, ...
        'Items', dropdownItems, ...
        'Position', [200, 300, 200, 30], ...
        'Visible', 'on');
        
        addStyle(dd, s1, "item", 3);
        addStyle(dd, s2, "item", 2);
        addStyle(dd, s3, "item", 1);
        addStyle(dd, s4, "item", 4);

        function checkDropdown(dd)
            selectedCategory = dd.Value;
            selectedWordSet  = selectedWords;
            
            correctCategoryWords = categories.(selectedCategory);
            
            if isempty(setdiff(selectedWordSet, correctCategoryWords)) && (numel(selectedWordSet)  && numel(correctCategoryWords))
                uialert(fig3, 'Correct!');
                dropdownItems(strcmp(dropdownItems, selectedCategory)) = [];
                resetSelection();
            else
                uialert(fig3, 'Incorrect, please try again.')
                resetSelection();
            end
        end

        uibutton(fig3, 'push', ...
            'Text', 'Submit', ...
            'Position', [100, 200, 100, 30], ...
            'ButtonPushedFcn', @(btn, ~) checkDropdown(dd));
    end
     
% purple

    

    function startGame(~, ~)
        fig1.Visible = 'off';
        fig3.Visible = 'off';
        fig2.Visible = 'on';
        fig4.Visible = 'off';
        displayGrid()

    end

    % making the function that will make it so once you press four words, if they are in the same category takes you to the next "correct" screen
    % if not, it will take you to incorrect screen
    function submit(~, ~)
        correctSets = {categories.Fruits, categories.Animals, categories.Colors, categories.Countries};
        
        isCorrect = false;
        for i = 1:length(correctSets) 
            if isempty(setdiff(selectedWords, correctSets{i})) && length(selectedWords) == length(correctSets{i}) %setdiff will make it so that the order of word selection won't matter 
                isCorrect = true;
                break;
            end
        end
    
        if isCorrect
            fig1.Visible = 'off';
            fig2.Visible = 'off';
            fig3.Visible = 'on';
            dropdownFunctionality()
        else
            fig1.Visible = 'off';
            fig2.Visible = 'off';
            fig4.Visible = 'on';
        end
        
        selectedWords = {}; % Reset selection after submission
    end   
    
    
    

    function resetSelection()
        selectedWords = {};
        displayGrid();
        dd.Value = '';
    end


    end
    % End the function
