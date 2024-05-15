% Read the CSV file into a cell array
%data = table2cell('email.csv');

% Extract the header row
header = data(1, :);

% Find the index of the "Message" column
message_col_index = find(strcmp(header, 'Message'));

% Check if the "Message" column exists
if isempty(message_col_index)
    error('The "Message" column is not present in the CSV file.');
end

% Extract the "Message" column, skipping the header row
message_column = data(2:end, message_col_index);

% Display the "Message" column
disp(message_column);

