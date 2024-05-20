function mainTest()
    % Define prefixes and suffixes
    suffixes = {'sses', 'ies', 'ness', 's', 'ing', 'ed', 'ful', 'ment', 'able', 'ly', 'ible', 'tion', 'ative', 'est', 'ize', 'ise', 'al', 'sion', 'er', 'est', 'e'};
    prefixes = {'un', 'sub', 'inter', 'semi', 'anti', 'over', 'under', 'bi', 'dis', 'pre', 're', 'mis'};
    
    % Load the stop words 
    stopWords = readStopWords('stopWords.txt');
    
    % Load the CSV file into a table
    data = readtable('email.csv');
    
    % Tokenize each message in the 'Message' column
    data.TokenizedMessage = cellfun(@(x) strsplit(x), data.Message, 'UniformOutput', false);

    % Process each message
    processedMessages = testPreprocessing(data, stopWords, prefixes, suffixes);

    % Add the processed messages to the table
    data.ProcessedMessage = processedMessages;

    % new csv
    writetable(data, 'processed_email.csv');

    % Print in terminal
    disp('Original - Processed');
    for i = 1:height(data)
        fprintf('%s - %s\n', data.Message{i}, data.ProcessedMessage{i});
    end
end

% Read file stopWords.txt
function stopWords = readStopWords(filename)
    fileID = fopen(filename, 'r');
    stopWords = textscan(fileID, '%s');
    fclose(fileID);
    stopWords = stopWords{1};
end

function processedMessages = testPreprocessing(data, stopWords, prefixes, suffixes)
    processedMessages = cell(size(data.TokenizedMessage));
    
    for i = 1:numel(data.TokenizedMessage)
        tokens = data.TokenizedMessage{i};
        processedTokens = cell(size(tokens));
        
        for k = 1:length(tokens)
            word = tokens{k};
            
            % Check for stop words
            if ismember(word, stopWords)
                continue; % Skip this word
            end
            
            % Remove prefix
            no_prefix = word;
            pre_removed = true;
            while pre_removed
                pre_removed = false;
                for j = 1:length(prefixes)
                    if startsWith(no_prefix, prefixes{j})
                        no_prefix = extractAfter(no_prefix, strlength(prefixes{j}));
                        pre_removed = true;
                        break;
                    end
                end
            end

            % Remove suffix
            result_word = no_prefix;
            suf_removed = true;
            while suf_removed
                suf_removed = false;
                for j = 1:length(suffixes)
                    if endsWith(result_word, suffixes{j})
                        result_word = extractBefore(result_word, strlength(result_word) - strlength(suffixes{j}) + 1);
                        suf_removed = true;
                        break;
                    end
                end
            end

            processedTokens{k} = result_word;
        end
        
        % remove stopWords
        processedTokens = processedTokens(~cellfun('isempty', processedTokens));
        
        % Store
        processedMessages{i} = strjoin(processedTokens, ' ');
    end
end
