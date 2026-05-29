% Input includes ingrained data

function [surface_cell] = get_surface_matrix(data, priority_row)
surface_cell{1, 4} = [];
% 1. Metric Vector, Ingrained Data (X axis)
% 2. Gait Percentage Vector (Y axis)
% 3. Data Matrix (Z axis)
% 4. Color Matrix

    % Interpolate data
    interpolated_data = get_interpolated_data(data);
 
    % Order the dataset by the appropriate measurement
    [~, idx] = sort(interpolated_data(priority_row, :));
    ordered_data = interpolated_data(:, idx);

    % Identify groups of the same
    start_end_indecies = [];
    start_end_pair = [];
    for i_col = 2 : (size(ordered_data, 2) - 1)
        prev_datum = ordered_data(priority_row, i_col - 1);
        this_datum = ordered_data(priority_row, i_col);
        next_datum = ordered_data(priority_row, i_col + 1);
    
        if isempty(start_end_pair) &&  (prev_datum == this_datum) % Looking for a start index
            start_end_pair = i_col - 1;
        end
        
        if ~isempty(start_end_pair) % Looking for an end index
            if (i_col == (size(ordered_data, 2) - 1)) && (this_datum == next_datum)
                start_end_pair = [start_end_pair, size(ordered_data, 2)];
            elseif this_datum ~= next_datum
                start_end_pair = [start_end_pair, i_col];
            end
        end
    
        if size(start_end_pair, 2) == 2 % Add the index-pair to the vector, then clear the index-pair container
            start_end_indecies = [start_end_indecies; start_end_pair];
            start_end_pair = [];
        end
    end

    % Assign Min-Max matrix - TO DO
    

    % Take the average of similar groups
    % Uses negative/backwards iteration
    cleaned_data = ordered_data;
    for i_row_pair = size(start_end_indecies, 1): - 1 : 1
        this_start_i = start_end_indecies(i_row_pair, 1);
        this_end_i = start_end_indecies(i_row_pair, 2);
        for i_col_data = this_start_i : this_end_i
            if i_col_data == this_start_i
                cleaned_data(:, i_col_data) = mean(ordered_data(:, this_start_i : this_end_i), 2);
            else
                cleaned_data(:, i_col_data) = NaN;
            end
        end
    end

    % Assign surface_matrix
    surface_matrix = [];
    for i_col = 1 : size(cleaned_data, 2)
        this_column = cleaned_data(:, i_col);
        if ~isnan(this_column(1))
            surface_matrix = [surface_matrix, [this_column(priority_row); this_column(5 : end)]]; % Hardcoded based on number of ingrained measurements
        end
    end
    surface_cell{3} = surface_matrix(2 : end, :);
    surface_cell{2} = linspace(0, 100, size(surface_cell{3}, 1));
    surface_cell{1} = surface_matrix(1, :);
    surface_cell{4} = repmat(surface_cell{1}, size(surface_cell{2}, 2), 1);
end
