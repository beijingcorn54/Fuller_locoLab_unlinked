% Input includes ingrained data

% surface_cell structure:
    % 1. Metric Vector, Ingrained Data (X axis)
    % 2. Gait Percentage Vector (Y axis)
    % 3. Data Matrix (Z axis)
    % 4. Color Matrix

% Advanced Functions:
    % A. Remove a participant's impact
    % B. Highlight a participant's impact
    % C. Automatically bucket data

function [surface_cell] = get_surface_matrix(data, priority_row, num_buckets, sub_highlight, sub_remove)
surface_cell{1, 4} = [];
surface_cell_1 = [];
surface_cell_3 = [];
    
    % A. Remove a participant's impact
    if ~isempty(sub_remove)
        for i_sub = 1 : size(sub_remove, 2)
            for i_col = 1 : size(data, 2)
                if data(5, i_col) == sub_remove(i_sub)
                    data(:, i_col) = NaN;
                end
            end
        end
    end

    % Interpolate data
    interpolated_data = get_interpolated_data(data);
 
    % Order the dataset by the appropriate measurement
    [~, idx] = sort(interpolated_data(priority_row, :));
    ordered_data = interpolated_data(:, idx);

    if ~num_buckets % B. Highlight a participant's impact

        % i. Identify groups of the same
        start_end_indecies = [];
        start_end_pair = zeros(1, 2);

        i_last = (size(ordered_data, 2) - 1);
        for i_col = 2 : i_last
            prev_datum = ordered_data(priority_row, i_col - 1);
            this_datum = ordered_data(priority_row, i_col);
            next_datum = ordered_data(priority_row, i_col + 1);

            finding_start_index = (start_end_pair(1) == 0);
            finished_pair = ~finding_start_index && (start_end_pair(2) ~= 0);
        
            % ia. Identify a start index
            if finding_start_index &&  (prev_datum == this_datum)
                start_end_pair(1) = i_col - 1;
            end
            
            % ib. Identify an end index
            if ~finding_start_index
                if (i_col == i_last) && (this_datum == next_datum)
                    start_end_pair(2) = i_last + 1;

                elseif this_datum ~= next_datum
                    start_end_pair(2) = i_col;
                end
            end
        
            % ic. Add the index-pair to the vector, then clear the index-pair container
            if finished_pair
                start_end_indecies = [start_end_indecies; start_end_pair];
                start_end_pair = zeros(1, 2);
            end
        end
    
        % ii. Take the average of similar groups
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
    
        % iii. Assign surface_matrix
        for i_col = 1 : size(cleaned_data, 2)
            this_column = cleaned_data(:, i_col);
            if ~isnan(this_column(1))
                surface_cell_1 = [surface_cell_1, this_column(priority_row)];
                surface_cell_3 = [surface_cell_3, this_column(6 : end)]; % Hardcoded based on number of ingrained measurements
            end
        end

        surface_cell_4 = surface_cell_3;
        if ~isempty(sub_highlight)
            for i_sub = 1 : size(sub_highlight, 2)
                for i_col = 1 : size(surface_cell_4, 2)
                    if cleaned_data(5, i_col) == sub_highlight(i_sub) % Hardcoded based on number of ingrained measurements
                        surface_cell_4(:, i_col) = surface_cell_4(:, i_col) * 10 * i_sub;
                    end
                end
            end
        end

    else % C. Automatically bucket data
        surface_cell_1 = zeros(1, num_buckets * 2); % X
        surface_cell_3 = zeros(size(ordered_data, 1) - 5, num_buckets * 2); % Z
                                                                            % Hardcoded based on ingrained measurements

        bucket_size_low = floor(size(ordered_data, 2) / num_buckets);
        for i_buckets = 1 : num_buckets
            
            % Chose start and end indecies of buckets
            if i_buckets == 1
                i_start = 1;
            else
                i_start = 1 + i_end;
            end
    
            if i_buckets == num_buckets
                i_end = size(ordered_data, 2);
            else
                i_end = bucket_size_low * i_buckets;
            end

            surface_cell_1(((2 * i_buckets) - 1) : (2 * i_buckets)) = [ordered_data(priority_row, i_start),  ordered_data(priority_row, i_end)];
            surface_cell_3(:, ((2 * i_buckets) - 1) : (2 * i_buckets)) = repmat(mean(ordered_data(6 : end, i_start : i_end), 2), 1, 2); % Hardcoded based on ingrained measurements
        end
        surface_cell_4 = surface_cell_3;
    end
    surface_cell{1} = surface_cell_1;
    surface_cell{3} = surface_cell_3;
    surface_cell{2} = linspace(0, 100, size(surface_cell{3}, 1));
    surface_cell{4} = surface_cell_4;
end
