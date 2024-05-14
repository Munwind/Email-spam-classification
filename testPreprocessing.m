fid = fopen('stopWords.txt', 'r');

% Initialize an empty cell array to store stop words
stopWords = {};

% Read the file line by line
line = fgetl(fid);
while ischar(line)
    stopWords{end+1} = line;
    line = fgetl(fid);
end

% Close the file
fclose(fid);

checkStopWord = 0;
for i = 1:numel(data.TokenizedMessage)
    for j = 1:numel(data.TokenizedMessage{i})
        word = data.TokenizedMessage{i}{j};
        if ismember(word, stopWords)
            checkStopWord = 1;
        end
    end
end

if checkStopWord == 1
    disp("Contain stop words!");
end

% Stemming step
checkForStemming =  0;
stemList = {};
suffix = {'sses', 'ies', 's', 'ness', 'ing', 'e', 'ed', 'ful', 'ment', 'able', 'ly', 'ible', 'tion', 'ative', 'est', 'ize', 'ise', 'al', 'sion', 'er', 'est'};
prefix = {'sub', 'inter', 'semi', 'anti', 'over', 'under', 'bi', 'dis', 'pre', 're', 'mis'};

for i = 1 : numel(data.TokenizedMessage)
    for j = 1 : numel(data.TokenizedMessage{i}) % Fix loop variable
        word = data.TokenizedMessage{i}{j};
        for k = 1 : length(suffix)
            if endsWith(word, suffix{k})
                checkForStemming = 1;
                stemList{end + 1} = word;
            end
        end

        for l = 1 : length(prefix) % Correct loop variable
            if startsWith(word, prefix{l}) % Use startsWith for prefix
                checkForStemming = 1;
                stemList{end + 1} = word;
            end
        end
    end
end

if checkForStemming == 1
    disp("Stemming error");
    disp(stemList);
end

