function result = reverse_inner_letters(s)
    words = strsplit(s);
    
    for i = 1:length(words)
        word = words{i};
        
        alphabetic_indices = find(isletter(word));
        if length(alphabetic_indices) > 2
            first_idx = alphabetic_indices(1);
            last_idx = alphabetic_indices(end);
            
            inner_letters = word(alphabetic_indices(2:end-1));
            reversed_inner = inner_letters(end:-1:1);
            
            word(alphabetic_indices(2:end-1)) = reversed_inner;
        end
        
        words{i} = word;
    end
    
    processed_string = strjoin(words, ' ');
    result = {processed_string};
end
