function [frequency, dict] = tf_idf(data)
    % Define the number of rows in the data matrix
    n = length(data);
    % Initialize frequency and dict
    dict = {};
    frequency = [];
    for i = 1:n-1
        small_dict = processing_doc(data{i+1, 2});
        length_small_dict = length(small_dict{1});

        % Initialize frequency matrix if empty
        if isempty(frequency)
            frequency = zeros(1, length_small_dict);
        else
            % Add a new row with all zeros to the frequency matrix
            frequency = vertcat(frequency, zeros(1, size(frequency, 2)));
        end

        for j = 1:length_small_dict
            word = small_dict{1}{j};
            index = find_word(word, dict);
            if index ~= -1
                % If the word is already in the dictionary, update its frequency
                frequency(end, index) = small_dict{2}(j);
            else
                % If the word is not in the dictionary, add it
                dict{end + 1} = word;
                index = length(dict);
                % Append a column of zeros to the frequency matrix for the new word
                frequency = horzcat(frequency, zeros(size(frequency, 1), 1));
                frequency(i, index) = small_dict{2}(j); % Set frequency of the new word
            end
        end
    end

    frequency = frequency(:, 1:length(dict));
    %disp(dict);
end