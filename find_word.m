function [index] = find_word(word, dict)
    n = length(dict);
    index = -1;
    for i = 1:n
        if strcmp(word, dict{i}) == 1
            index = i;
            return;
        endif
    endfor
endfunction

