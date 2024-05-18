% Prefixes and suffixes
suffixes = {'sses', 'ies', 's', 'ness', 'ing', 'e', 'ed', 'ful', 'ment', 'able', 'ly', 'ible', 'tion', 'ative', 'est', 'ize', 'ise', 'al', 'sion', 'er', 'est'};
prefixes = {'sub', 'inter', 'semi', 'anti', 'over', 'under', 'bi', 'dis', 'pre', 're', 'mis'};

fileID = fopen('input.txt', 'r'); % input.txt to test
strs = textscan(fileID, '%s');
fclose(fileID);

strs = strs{1};
res_strs = cell(size(strs));

for k = 1:length(strs)
    cur = strs{k};
    
    % prefix
    no_prefix = cur;
    pre_removed = true;
    while pre_removed
        pre_removed = false;
        for i = 1:length(prefixes)
            if startsWith(no_prefix, prefixes(i))
                no_prefix = extractAfter(no_prefix, strlength(prefixes(i)));
                pre_removed = true;
                break;
            end
        end
    end

    % suffix
    result_word = no_prefix;
    suf_removed = true;
    while suf_removed
        suf_removed = false;
        for i = 1:length(suffixes)
            if endsWith(result_word, suffixes(i))
                result_word = extractBefore(result_word, strlength(result_word) - strlength(suffixes(i)) + 1);
                suf_removed = true;
                break;
            end
        end
    end

    res_strs{k} = result_word;
end

% Write res in file
fileID = fopen('output.txt', 'w');
for k = 1:length(res_strs)
    fprintf(fileID, '%s\n', res_strs{k});
end
fclose(fileID);

% Print to check
disp('Origin - Results');
for k = 1:length(strs)
    fprintf('%s - %s\n', strs{k}, res_strs{k});
end

% somthing we don't need
% Remove prefix
function result = remove_prefix(text, prefix)
    if startsWith(text, prefix)
        result = extractAfter(text, strlength(prefix));
    else
        result = text;
    end
end

% Remove suffix
function result = remove_suffix(text, suffix)
    if endsWith(text, suffix)
        result = extractBefore(text, strlength(text) - strlength(suffix) + 1);
    else
        result = text;
    end
end
