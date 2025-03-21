function category_connections_gui()

    %initializing the solved list
    solvedList = {};

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
        'Text', sprintf(['Welcome to Category Connections!\n' ...
        'Click the button below to Start the Game.\n\n' ...
        'The goal is to group four similar words together into one category!\n\n' ...
        'Created by Kaluki, Selam, and Shayla']), ...
        'Position', [50, 400, 500, 120], ...  % Increase height to 100 for better text wrapping
        'HorizontalAlignment', 'center', ...
        'FontName', 'Georgia', ...
        'FontSize', 16, ...
        'WordWrap', 'on'); 

    % Create the GUI figure
    fig2 = uifigure('Name', 'Category Connections', 'Position', [100, 100, 600, 400], 'Visible', 'off');

    % creates the start button and when clicked switches from the welcome page to the grid
    uibutton(fig1, 'push', ...
        'Text', 'Click to Play!', ...
        'Position', [250, 200, 100, 30], ...
        'FontName', 'Georgia', ...
        'ButtonPushedFcn', @startGame);

        function displayGrid()
            delete(grid.Children); % Clear the grid
            for row = 1:4
                for col = 1:4
                    wordButton = uibutton(grid, 'push', ...
                        'Text', shuffledWords{row, col}, ...
                        'FontName', 'Georgia', ...
                        'FontSize', 18, ...
                        'ButtonPushedFcn', @(btn, ~) wordButtonPushed(btn));
                    wordButton.Layout.Row = row;
                    wordButton.Layout.Column = col;
        
                    % Disable the button if the word is in the solved list
                    if ismember(shuffledWords{row, col}, solvedList)
                        wordButton.Enable = 'off'; % Disable the button
                        wordButton.BackgroundColor = [0.8, 0.8, 0.8]; % Gray out the button
                    else
                        wordButton.Enable = 'on';
                        wordButton.BackgroundColor = [0.94, 0.94, 0.94];
                    end
                end
            end
        end


    function shuffleWords()
        shuffledWords = allWords(randperm(length(allWords)));
        shuffledWords = reshape(shuffledWords, 4, 4);
        displayGrid();
    end

    %create grid layout for words 
    grid = uigridlayout(fig2, [5, 4]);  % 5 rows: 4 for words, 1 for buttons
        grid.RowHeight = {'4x', '4x', '4x', '4x', '2x'}; % Extra row for buttons
        grid.ColumnWidth = {'5x', '5x', '5x', '5x'}; % Keep columns equal

    % figure fot the toggle/ category choose page
    fig3 = uifigure('Name', 'Correct! Select a catgory', 'Position', [100, 100, 600, 600], 'Visible', 'off');

    % figure for if the connection is incorret
    fig4 = uifigure('Name', 'Incorrect', 'Position', [100, 100, 600, 600], 'Visible', 'off');


    uilabel(fig4, ...
        'Text', 'Sorry, try again.' , ...
        'Position', [50, 550, 500, 50], ...
        'FontName', 'Georgia', ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16); 
    

    fig5 = uifigure('Name', 'Congratulations!', ...
     'Position', [100, 100, 600, 600], ...
     'Visible', 'off');

     uilabel(fig5, ...
        'Text', sprintf(['Congraulations! You have completed the game, \n\n' ...
        'Thank you playing Category Connections.']), ...
        'Position', [50, 400, 500, 100], ...
        'FontName', 'Georgia', ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16);




    celebrationArt = sprintf(['      ☆ ☆ ☆ ☆ ☆      \n' ...
                            '   ☆ (づ｡◕‿‿◕｡)づ ☆   \n' ...
                            ' ☆  Congrats!!!  ☆  \n' ...
                            '   ☆ You got it! ☆   \n' ...
                            '      ☆ ☆ ☆ ☆ ☆      ']);
    uilabel(fig3, ...
        'Text', celebrationArt , ...
        'Position', [50, 400, 500, 100], ...
        'FontName', 'Georgia', ...
        'HorizontalAlignment', 'center', ...
        'FontSize', 16); 




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
                'FontName', 'Georgia', ...
                'FontSize',18,...
                'ButtonPushedFcn', @(btn, ~) wordButtonPushed(btn));
            wordButton.Layout.Row = row;
            wordButton.Layout.Column = col;
        end
    end


    % Add a "Close" button
    uibutton(fig2, 'push', ...
        'Text', 'Close', ...
        'FontName', 'Georgia', ...
        'Position', [350, 15, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) close(fig2));
        
    % Add a "Close" button on the last page
        uibutton(fig5, 'push', ...
        'Text', 'Close', ...
        'FontName', 'Georgia', ...
        'Position', [350, 15, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) close(fig5));
    
    % Add a "Submit" button
    uibutton(fig2, 'push', ...
        'Text', 'Submit', ...
        'FontName', 'Georgia', ...
        'Position', [250, 15, 100, 30], ...
        'ButtonPushedFcn', @submit);  
        'Visible'; 'off'; % Start hidden;

    % Add a "Shuffle Words" button
    uibutton(fig2, 'push', ...
        'Text', 'Shuffle Words',...
        'FontName', 'Georgia', ...
        'Position', [150, 15, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) shuffleWords());

    % Define styles for the dropdown
     s1 = uistyle("BackgroundColor", "#ffec33"); %yellow
     s2 = uistyle("BackgroundColor", "#8adc75"); % green
     s3 = uistyle("BackgroundColor", "#75a9dc"); % blue
     s4 = uistyle("BackgroundColor", "#ac75dc"); 

     function dropdownFunctionality()
        dropdownItems = {'Fruits', 'Animals', 'Colors', 'Countries'};
        dd = uidropdown(fig3, ...
            'Items', dropdownItems, ...
            'FontName', 'Georgia', ...
            'Position', [200, 300, 200, 30], ...
            'Visible', 'on');
    
        addStyle(dd, s1, "item", 3);
        addStyle(dd, s2, "item", 2);
        addStyle(dd, s3, "item", 1);
        addStyle(dd, s4, "item", 4);
    
        function checkDropdown(dd)
            selectedCategory = dd.Value; % Get the selected category from the dropdown
            selectedWordSet = selectedWords; % Get the selected words
            
            correctCategoryWords = categories.(selectedCategory); % Get the correct words for the selected category
            
            % Check if the selected words match the correct category
            if isempty(setdiff(selectedWordSet, correctCategoryWords)) && ...
               (numel(selectedWordSet) == numel(correctCategoryWords))
                % Correct category selected
                uialert(fig3, 'Correct!', 'Success');
                
                % Add the selected words to the solved list
                solvedList = [solvedList, selectedWordSet];

                if numel([categories.Fruits, categories.Animals, ...
                    categories.Countries, categories.Colors]) == numel(unique(solvedList))
                    fig1.Visible = 'off';
                    fig2.Visible = 'off';
                    fig3.Visible = 'off';
                    fig4.Visible = 'off';
                    fig5.Visible = 'on';
                    endGame();
                else
                    % Return to the main grid
                    fig3.Visible = 'off'; % Hide the category selection screen
                    fig2.Visible = 'on'; % Show the main grid
                
                    % Refresh the grid to disable the solved buttons
                    displayGrid();
                
                    % Reset the selection for the next round
                    resetSelection();

                end

            else
                % Incorrect category selected
                uialert(fig3, 'Incorrect, please try again.', 'Error');
            end
            
            % Reset the dropdown value
            dd.Value = '';
        end

        %add a submit function
        uibutton(fig3, 'push', ...
            'Text', 'Submit', ...
            'FontName', 'Georgia', ...
            'Position', [100, 200, 100, 30], ...
            'ButtonPushedFcn', @(btn, ~) checkDropdown(dd));
    end
    
    % Start game function
    function startGame(~, ~)
        fig1.Visible = 'off';
        fig3.Visible = 'off';
        fig2.Visible = 'on';
        fig4.Visible = 'off';
        displayGrid();
    end
    
    function submit(~, ~)
        % Check if the selected words match any correct set
        correctSets = {categories.Fruits, categories.Animals, categories.Colors, categories.Countries};
        isCorrect = false;
    
        for i = 1:length(correctSets)
            if isequal(sort(selectedWords), sort(correctSets{i})) 
                isCorrect = true;
                solvedList = [solvedList, selectedWords]; % Add the selected words to the solved list
                
                break;
            end
        end
    
        % Handle correct and incorrect cases
        if isCorrect
            disp('Correct set selected! Moving to dropdown...');
            fig1.Visible = 'off';
            fig2.Visible = 'off';
            fig3.Visible = 'on';
            dropdownFunctionality();
        else
            disp('Incorrect set selected. Showing incorrect screen.');
            fig1.Visible = 'off';
            fig2.Visible = 'off';
            fig4.Visible = 'on';
    
            % Fix for incorrect screen timeout
            t = timer('StartDelay', 2, 'TimerFcn', @(~,~) closeIncorrectScreen());
            start(t);
            resetSelection();
        end
    end

    function resetSelection()
        selectedWords = {}; % Clear the selected words
    end

    % Close incorrect screen and return to game grid
   function closeIncorrectScreen()
        if isvalid(fig4)  % Check if fig4 still exists before modifying it
            fig4.Visible = 'off'; % Hide incorrect screen
            fig3.Visible = 'on'; % Show correct screen
        end
        if isvalid(fig2)  % Ensure fig2 exists
            fig2.Visible = 'on';  % Bring back the game grid
        end
    end

    function endGame()
        for iter = 5:-1:1
            close(fig(iter))
        end
    end


 
end