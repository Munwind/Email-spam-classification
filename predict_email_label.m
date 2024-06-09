function predict_email_label(input_text)
    % Load the necessary data (dictionary, idfMatrix, weights, and stopWords)
    load('matlab.mat', 'dict', 'idfMatrix', 'weight', 'stopWords');

    % Preprocess the input text
    input_text = lower(input_text); % Convert to lowercase
    input_text = regexprep(input_text, '[^\w\s]', ''); % Remove punctuation
    tokens = strsplit(input_text); % Tokenize
    
    % Remove stop words
    tokens = tokens(~ismember(tokens, stopWords));
    
    % Combine tokens back into a single string
    processed_input_text = strjoin(tokens, ' ');
    
    % Vectorize the input text
    input_tfMatrix = vectorize_new_emails({processed_input_text}, dict);
    
    % Apply TF-IDF transformation
    input_tf_idf_data = input_tfMatrix .* idfMatrix;
    
    % Add bias term
    input_tf_idf_data = [1 input_tf_idf_data]; % Adding 1 for the bias term
    
    % Predict the label
    prediction = predicted_function(input_tf_idf_data * weight');
    
    % Threshold and determine the label
    threshold = 0.5;
    predicted_label = prediction >= threshold;
    
    % Display the result
    if predicted_label
        fprintf('The email is predicted to be: SPAM, with the rate is %.2f%%\n', prediction * 100);
    else
        fprintf('The email is predicted to be: HAM, with the rate is %.2f%%\n', (1- prediction) * 100);
    end
end

function tfMatrix = vectorize_new_emails(emails, dict)
    % This function vectorizes the emails based on the given dictionary.
    % Convert emails into TF matrix
    numEmails = numel(emails);
    numWords = numel(dict);
    tfMatrix = zeros(numEmails, numWords);
    
    for i = 1:numEmails
        words = strsplit(emails{i});
        for j = 1:numel(words)
            wordIdx = find(strcmp(dict, words{j}));
            if ~isempty(wordIdx)
                tfMatrix(i, wordIdx) = tfMatrix(i, wordIdx) + 1;
            end
        end
    end
end

function prediction = predicted_function(scores)
    % This function applies a sigmoid function to scores to obtain predictions
    prediction = 1 ./ (1 + exp(-scores));
end

