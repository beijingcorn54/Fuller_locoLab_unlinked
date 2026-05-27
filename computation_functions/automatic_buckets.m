function [bucket_set] = automatic_buckets(data, priority_row, bucket_number, get_average_std)
bucket_set{3, bucket_number} = [];

    % Order the dataset by the appropriate measurement
    [~, idx] = sort(data(priority_row, :));
    ordered_data = data(:, idx);

    % Put into buckets
    bucket_size_low = floor(size(data, 2) / bucket_number);
    for i_buckets = 1 : bucket_number
        
        % Chose start and end indecies of buckets
        if i_buckets == 1
            i_start = 1;
        else
            i_start = 1 + i_end;
        end

        if i_buckets == bucket_number
            i_end = size(data, 2);

        else
            i_end = bucket_size_low * i_buckets;
        end

        % 1. Add bucketed data
        data_to_append = ordered_data(:, i_start : i_end);
        
        if get_average_std % Get average and std version
            bucket_set{1, i_buckets} = get_mean_std_vector(data_to_append);
        else
            bucket_set{1, i_buckets} = data_to_append;
        end

        % 2. Add bucket min/max
        bucket_set{2, i_buckets} = [data_to_append(priority_row, 1), data_to_append(priority_row, end)];

        % 3. Add number of trials per bucket
        bucket_set{3, i_buckets} = size(data_to_append, 2);
    end
end