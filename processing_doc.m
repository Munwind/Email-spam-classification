function [small_dict] = processing_doc(doc)
    num_of_word = 0;
    small_dict = {{}, []}; % Initialize small_dict as a cell array with two empty arrays
    n = length(doc);
    word = "";
    for i = 1:n
        if doc(i) == " "
            if ~isempty(word)
                num_of_word = num_of_word + 1;
                index = find_word(word, small_dict{1});
                if index ~= -1
                    small_dict{2}(index)
                else
                    small_dict{1}{end+1} = word; % Append word to the cell array
                    small_dict{2}(end+1) = 1;     % Append count (initialized to 1) to the array
                end
                word = "";
            end
        else
            word = strcat(word, doc(i));
                end
            end
    % Handle the last word in the document
    if ~isempty(word)
        num_of_word = num_of_word + 1;
        index = find_word(word, small_dict{1});
        if index ~= -1
            small_dict{2}(index) = small_dict{2}(index) + 1;
        else
            small_dict{1}{end+1} = word; % Append word to the cell array
            small_dict{2}(end+1) = 1;     % Append count (initialized to 1) to the array
        end
    end

    % Normalize frequencies
    small_dict{2} = log(num_of_word ./ small_dict{2}) .* (small_dict{2} / num_of_word);
end

