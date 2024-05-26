clc;clear;
% Load email data
data = readtable('email.csv');

% Extract Category and Message columns
categories = data.Category;
messages = data.Message;

% Define stop words
fileID = fopen('stopWords.txt', 'r');
stopWordsCell = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);
stopWords = string(stopWordsCell{1});

% Convert all text to lowercase
messages = lower(messages);
messages = regexprep(messages, '[^\w\s]', '');

% Split messages into words (tokenize)
wordTokens = cellfun(@(msg) strsplit(msg), messages, 'UniformOutput', false);

% Remove stop words
cleanedWordTokens = cellfun(@(tokens) tokens(~ismember(tokens, stopWords)), wordTokens, 'UniformOutput', false);

% Initialize processed messages
processedMessages = cell(size(cleanedWordTokens));

% Define prefixes and suffixes
suffixes = {'sses', 'ies', 'ness', 'ing', 'ed', 'ful', 'ment', 'able', 'ly', 'ible', 'tion', 'ative', 'est', 'ize', 'ise', 'al', 'sion', 'er', 'est', 'e'};
prefixes = {'un', 'sub', 'inter', 'semi', 'anti', 'over', 'under', 'bi', 'dis', 'pre', 're', 'mis'};

% Process each message
for i = 1:numel(cleanedWordTokens)
    tokens = cleanedWordTokens{i};
    processedTokens = {};
    
    for k = 1:length(tokens)
        word = tokens{k};
        
        % Remove prefix
        no_prefix = word;
        for j = 1:length(prefixes)
            if startsWith(no_prefix, prefixes{j})
                no_prefix = extractAfter(no_prefix, strlength(prefixes{j}));
                break;
            end
        end

        % Check if the word ends with a period
        ends_with_period = endsWith(no_prefix, '.');
        if ends_with_period
            temp_word = extractBefore(no_prefix, strlength(no_prefix));
        else
            temp_word = no_prefix;
        end
        
        % Remove suffix
        result_word = temp_word;
        for j = 1:length(suffixes)
            if endsWith(result_word, suffixes{j})
                result_word = extractBefore(result_word, strlength(result_word) - strlength(suffixes{j}) + 1);
                break;
            end
        end
        
        if ends_with_period
            result_word = result_word + ".";
        end

        % Add processed word to the tokens
        processedTokens{end+1} = char(result_word);
    end
    
    % Store processed message as a single string
    processedMessages{i} = strjoin(processedTokens, ' ');
end

% Combine categories with processed messages
finalOutput = cell(numel(categories), 2);
for i = 1:numel(categories)
    finalOutput{i, 1} = categories{i};
    finalOutput{i, 2} = processedMessages{i};
end

% Display final output
disp(finalOutput);
