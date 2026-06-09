% Stacks the data and gets interpolated data
% Input data includes the ingrained measurements
% Output data includes the ingrained measurements

function [interpolated_data] = get_interpolated_data(data)
    data_no_ingrained = data(6 : end, :); % Hardcoded based on number of ingrained measurements
    
    % Stack the data
    stacked_data{1, size(data_no_ingrained, 2)} = [];
    
     for i_col = 1 : size(data_no_ingrained, 2)
         stacked_column = [];
    
          for i_row = 1 : size(data_no_ingrained, 1)
              this_datum = data_no_ingrained(i_row, i_col);
    
              if ~isnan(this_datum)
                  stacked_column = [stacked_column; this_datum];
              end
          end
    
          stacked_data{i_col} = stacked_column;
     end
    
    % Find maximum length of data
    max_data_length = 0;
    for i_col = 1 : size(stacked_data, 2)
        this_data_length = size(stacked_data{i_col}, 1);
        
        if this_data_length > max_data_length
            max_data_length = this_data_length;
        end
    end
    
    % Interpolate data
    interpolated_data = [];
    for i_col = 1 : size(stacked_data, 2)
        if ~isnan(stacked_data{i_col})
            this_length = size(stacked_data{i_col}, 1);
        
            x = 1 : this_length;
            y = stacked_data{i_col};
        
            interpolate_x = linspace(1, this_length, max_data_length);
            interpolate_y = interp1(x, y, interpolate_x)';
    
            interpolated_data = [interpolated_data, [data(1 : 5, i_col); interpolate_y]]; % Hardcoded based on number of ingrained measurements
        end
    end
end
