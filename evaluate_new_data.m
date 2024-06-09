
load('matlab.mat');
emails_data = {
    "spam", 'Congratulations! You win a free vacation! Click here to claim your prize now! ';%1
    "spam", 'Get rich easily with this amazing investment opportunity! Only 100$ for being a great business and achieve a millionaire life!'; %2
    "spam", 'This is the second time we have tried to contact you. You have won the $4000. 2 claim is easy, just call 091828328387'; %3
    "spam", 'You''ve been selected as the winner of our monthly sweepstakes! Click the link below to claim your $1000 gift card. Hurry, this offer expires in 24 hours!'; %4
    "ham", 'Hi there, just wanted to check in about the project meeting next week.'; %5
    "ham", 'URGENT: Your account has been compromised. Update your password immediately.'; %6
    "ham", 'Good morning, I hope you had a great weekend. Please find attached the report for last month''s performance.'; %7
    "ham", 'Hi there, I wanted to touch base about the upcoming meeting. Could you let me know your availability?'; %8
    "spam", 'Congratulation!, You are the only one who claim free IPhone 15 Pro Max, please contact to 020209029 to receive your gift'; %9
    "spam", 'URGENT: Your account has been compromised. Click the link to secure your account now.'; %10
    "ham", 'Good afternoon, I wanted to follow up on the proposal we discussed last week. Let''s schedule a meeting to go over the details.'; %11
    "ham", 'Hello, attached is the agenda for tomorrow''s conference call. Please review it prior to the meeting.'; %12
    "ham", 'This email is sent by Vu Van Thieu'; %13
    "spam", 'You will receive free 1000 dollars. Click this link and claim now'; %14
    "spam", 'Exclusive offer! Buy one get one free on all items. Limited time only.'; %15
    "spam", 'Congratulations! You win a free iPad. Click here to claim your prize.'; %16
    "spam", 'Congratulations, you have been accepted for a new credit card with a $10,000 limit. Please contact me to claim your card'; %17
    "ham", 'Just checking in to see if you received the document I sent last week.'; %18
    "ham", 'Don''t forget about the team meeting tomorrow at 3 PM. See you there!'; %19
    "ham", 'Here are the minutes from yesterday''s meeting. Please review and provide feedback.'; %20
    "ham", 'Happy Holidays! Wishing you a joyful season with your loved ones.'; %21
    "ham", 'Please find attached the updated project plan. Let me know if you have any questions.'; %22
    "ham", 'Just a reminder to submit your timesheets by end of day.'; %23
    "ham", 'I wanted to share some exciting news about our recent project success.'; %24
    "ham", 'Can we reschedule our meeting to next week? Let me know your availability.'; %25
};

% New data processing
new_data_label = emails_data(:, 1);
new_data_message = emails_data(:, 2);

% Convert all text to lowercase
new_data_message = lower(new_data_message);
new_data_message = regexprep(new_data_message, '[^\w\s]', '');

fileID = fopen('stopWords.txt', 'r');
stopWordsCell = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);
stopWords = string(stopWordsCell{1});

% Split messages into words and remove stop words (tokenize)
new_data_wordTokens = cellfun(@(msg) strsplit(msg), new_data_message, 'UniformOutput', false);
clean_new_data_Tokens = cellfun(@(tokens) tokens(~ismember(tokens, stopWords)), new_data_wordTokens, 'UniformOutput', false);

newdata_processedMessages = cell(size(clean_new_data_Tokens));
%newdata_processedMessages = cell(size(clean_new_data_Tokens));
% Process each message
for i = 1:numel(clean_new_data_Tokens)
    new_data_tokens = clean_new_data_Tokens{i};
    processed_newdataTokens = {};
    
    for k = 1:length(new_data_tokens)
        new_word = new_data_tokens{k};
        
        % Remove prefix and suffix (No prefix and suffix removal specified in the new requirement)
        processed_newdataTokens{end+1} = new_word;
    end
    
    % Store processed message as a single string
    newdata_processedMessages{i} = strjoin(processed_newdataTokens, ' ');
end

% Combine categories with processed messages
new_finalOutput = [num2cell(new_data_label), newdata_processedMessages];

% Display final output
disp(new_finalOutput);

% Apply TF-IDF to new data
new_tfMatrix = vectorize_new_emails(newdata_processedMessages, dict);
new_tf_idf_data = new_tfMatrix .* idfMatrix;
% Add bias term
num_newDocuments = size(new_tf_idf_data, 1);
new_tf_idf_data = [ones(num_newDocuments, 1) new_tf_idf_data];

% Predict labels for new data
new_prediction = predicted_function(new_tf_idf_data * weight');
new_data_label = cellfun(@(label) strcmp(label, 'spam'), new_data_label);
% Threshold and calculate accuracy
threshold = 0.5; % Set the threshold
new_predict_labels = new_prediction >= threshold;
accuracy = sum(new_predict_labels == new_data_label) / num_newDocuments;
spam_predicted_accuracy = sum(new_predict_labels == 1 & new_data_label == 1) / sum(new_data_label ==1);
ham_predicted_accuracy = sum(new_predict_labels == 0 & new_data_label == 0) / sum(new_data_label == 0);

% Display final output with predicted labels and accuracy
disp("Final Output with Predicted Labels and Accuracy:");
for i = 1:numel(new_predict_labels)
    fprintf('Message %d - Reality Label: %d, Predicted Label: %d\n', i, new_data_label(i), new_predict_labels(i));
end
fprintf('Accuracy: %.2f%%\n', accuracy * 100);
fprintf('Rate at classify spam email: %.2f%%\n', spam_predicted_accuracy * 100);
fprintf('Rate at classify ham email: %.2f%%\n', ham_predicted_accuracy * 100);


%Enter input now please my friend
while(true)
    input_text = input('Enter the email content(quit to end your work): ', 's');
    process_input = lower(input_text);
    if strcmpi(process_input, 'quit')
        break;
    end
    predict_email_label(input_text);
end