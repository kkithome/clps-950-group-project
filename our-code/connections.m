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
            'Text', sprintf(['Welcome to Category Connections!\n' ...
            'Click the button below to Start the Game.\n\n' ...
            'The goal is to group four similar words together into one category!\n\n' ...
            'Created by Kaluki, Selam, and Shayla']), ...
            'FontName', 'Georgia', ...       
            'Position', [50, 320, 500, 200], ...  
            'HorizontalAlignment', 'center', ...
            'FontSize', 18, ...
            'WordWrap', 'on'); 

        % Create the GUI figure
        fig2 = uifigure('Name', 'Category Connections', 'Position', [100, 100, 600, 400], 'Visible', 'off');

        % creates the start button and when clicked switches from the welcome page to the grid
        uibutton(fig1, 'push', ...
            'Text', 'Click to Play!', ...
            'FontName', 'Georgia', ...  
            'Position', [250, 200, 100, 30], ...
            'ButtonPushedFcn', @startGame);

        function displayGrid()
            delete(grid.Children);
            for row = 1:4
                for col = 1:4
                    wordButton = uibutton(grid, 'push', ...
                    'Text', shuffledWords{row, col}, ...
                    'FontName', 'Georgia', ...
                    'FontSize',14,...
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


        % Create a grid layout for the words and buttons
        grid = uigridlayout(fig2, [5, 4]);  % 5 rows: 4 for words, 1 for buttons
        grid.RowHeight = {'4x', '4x', '4x', '4x', '1x'}; % Extra row for buttons
        grid.ColumnWidth = {'5x', '5x', '5x', '5x'}; % Keep columns equal

        % figure fot the toggle/ category choose page when correct 
        fig3 = uifigure('Name', 'Correct! Select a catgory', 'Position', [100, 100, 600, 600], 'Visible', 'off');

        % figure for if the connection is incorret, to retry 
        fig4 = uifigure('Name', 'Incorrect', 'Position', [100, 100, 600, 600], 'Visible', 'off');

        uilabel(fig4, ...
            'Text', 'Sorry, try again :(' , ...
            'FontName', 'Georgia', ...  
            'Position', [50, 550, 500, 50], ...
            'HorizontalAlignment', 'center', ...
            'FontSize', 16); 
        % add text to incorrect page: 

        % Added text to the welcome page
        celebrationArt = sprintf(['      ☆ ☆ ☆ ☆ ☆      \n' ...
                            '   ☆ (づ｡◕‿‿◕｡)づ ☆   \n' ...
                            ' ☆  Congrats!!!  ☆  \n' ...
                            '   ☆ You got it! ☆   \n' ...
                            '      ☆ ☆ ☆ ☆ ☆      ']);

        uilabel(fig3, ...
            'Text', celebrationArt, ...
            'FontName', 'Courier', ...  % Monospace for ASCII alignment
            'Position', [100, 350, 400, 150], ...
            'FontSize', 18, ...
            'HorizontalAlignment', 'center');
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

        % When a word is selected, the game should:
            % if less than four words are selected:
                % Highlight the box
                % add the word to an going list
            % if four words are already selected:
                % allow the user to submit 


        % Add a "Close" button
        uibutton(fig2, 'push', ...
            'Text', 'Close', ...
            'FontName', 'Georgia', ...  
            'Position', [350, 0, 100, 30], ...
            'ButtonPushedFcn', @(btn, event) close(fig2));

        uibutton(fig2, 'push', ...
            'Text', 'Submit', ...
            'FontName', 'Georgia', ...  
            'Position', [250, 0, 100, 30], ...
            'ButtonPushedFcn', @submit);  
            'Visible'; 'off'; % Start hidden;
        
        uibutton(fig2, 'push', ...
            'Text', 'Shuffle Words',...
            'FontName', 'Georgia', ...  
            'Position', [150, 0, 100, 30], ...
            'ButtonPushedFcn', @(btn, event) shuffleWords());
    


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

                % Start a timer to hide fig3 after 3 seconds and bring back fig2
                t = timer('StartDelay', 3, 'TimerFcn', @(~,~) closeIncorrectScreen());
                start(t);

                % selectedWords = {}; % Reset selection after submission !
                displayGrid();
            else
                fig1.Visible = 'off';
                fig2.Visible = 'off';
                fig4.Visible = 'on';
        
            
                selectedWords = {}; % Reset selection after submission

                % Start a timer to hide fig4 after 3 seconds and bring back fig2
                t = timer('StartDelay', 3, 'TimerFcn', @(~,~) closeIncorrectScreen());
                start(t);
            
                % selectedWords = {}; % Reset selection after submission !
                displayGrid();
            end
        end

    function closeIncorrectScreen()
        if isvalid(fig4)  % Check if fig4 still exists before modifying it
        fig4.Visible = 'off'; % Hide incorrect screen
        fig3.Visible = 'off'; % hide celebrate 
        end
        if isvalid(fig2)  % Ensure fig2 exists
        fig2.Visible = 'on';  % Bring back the game grid
        end
        end    
        % End the function
    end