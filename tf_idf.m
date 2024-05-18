function [tfidfMatrix, dict] = tf_idf(data)
    % Exclude the first row of data
    data = data(2:end, :);
    % Load the number of documents
    numDocs = size(data, 1);

    % Create token cell array
    allTokens = cell(numDocs, 1);

    % Each documents will be splited into tokens, which strsplit can be replaced with tokenize
    for i = 1:numDocs
      allTokens{i} = strsplit(data{i, 2}, ' ');
    endfor
    % Create a dictionary
    dict = unique([allTokens{:}]);
    % Load the number of terms
    numTerms = length(dict);

    % Create term frequency matrix
    tf = zeros(numDocs, numTerms);
    % Assign value to tf matrix
    for i = 1: numDocs
      for j = 1:numTerms
        tf(i, j) = sum(strcmp(allTokens{i}, dict{j}));
      endfor
    endfor
    % Calculate documents frequency of each word
    df = sum(tf > 0, 1);
    % Calculate Inverse Document Frequency
    idf = log(numDocs ./ df);
    % Calculate IF-IDF
    tfidfMatrix = tf .* idf;
end
