function new_tf_matrix = vectorize_new_emails(new_emails, dict)
    % Collect all tokens into a single cell array
    all_tokens = {};
    for i = 1:numel(new_emails)
        all_tokens = [all_tokens, strsplit(new_emails{i}, ' ')];
    end

    % Create term frequency matrix
    num_terms = length(dict);
    num_new_docs = numel(new_emails);
    tf = zeros(num_new_docs, num_terms);

    % Populate term frequency matrix
    for i = 1:num_new_docs
        email_tokens = strsplit(new_emails{i}, ' ');
        for j = 1:num_terms
            new_tf_matrix(i, j) = sum(strcmp(email_tokens, dict{j}));
        end
    end
end
