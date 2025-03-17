categories.Fruits = {'Apple', 'Banana', 'Orange', 'Grapes'};
categories.Animals = {'Dog', 'Cat', 'Elephant', 'Lion'};
categories.Colors = {'Red', 'Blue', 'Green', 'Yellow'};
categories.Countries = {'USA', 'Canada', 'France', 'Japan'};

allWords = [categories.Fruits, categories.Animals, categories.Colors, categories.Countries];
shuffledWords = allWords(randperm(length(allWords))); 

% Reshape into a 4x4 matrix for display
shuffledWords = reshape(shuffledWords, 4, 4)';

% Display the shuffled words
disp('Shuffled Words (4x4 Grid):');
disp(shuffledWords);


git commit -m 'created categories and found way to shuffle the categories useing the randperm function'

