clear;
close all;

% Control (Dynamic) Variables
export_to_pdf = false;
pdf_file_name = "Torque and Angle Surfaces, All Speeds.pdf";
speed_filter = false;
by_incline = false;
num_buckets = false;
sub_highlight = [2];    % Cadence trials are never highlighted 
                        % because many steps are of the same cadence. 
                        % The average of these cadences are from 
                        % multiple people, so one person cannot be highlighted
sub_remove = [];

% Static Variables
force_threshold = 25;
subjects = ["AB01", "AB02", "AB03", "AB04", "AB05", "AB06", "AB07", "AB08", "AB09", "AB10"];
legLengths = [0.951, 0.921, 0.99, 0.96, 0.766, 0.918, 0.859, 0.991, 0.940, 0.815];
speeds = ["s0x8", -0.8; "s1", -1; "s1x2", -1.2];
inclines = ["i10", 10; "i5", 5; "i0", 0; "in5", -5; "in10", -10];

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;

% Develop data via function calls
incline_vector = inclines(5, :);
addpath(directory + 'computation_functions/');
[in10_A_t, in10_K_t, in10_A_a, in10_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(4, :);
addpath(directory + 'computation_functions/');
[in5_A_t, in5_K_t, in5_A_a, in5_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(3, :);
addpath(directory + 'computation_functions/');
[i0_A_t, i0_K_t, i0_A_a, i0_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(2, :);
addpath(directory + 'computation_functions/');
[i5_A_t, i5_K_t, i5_A_a, i5_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(1, :);
addpath(directory + 'computation_functions/');
[i10_A_t, i10_K_t, i10_A_a, i10_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

% Plot based off metric and joint
% Ankle Torque
if ~by_incline
    make_surface(in10_A_t, speed_filter, directory, -10, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_A_t, speed_filter, directory, -5, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_A_t, speed_filter, directory, 0, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_A_t, speed_filter, directory, 5, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_A_t, speed_filter, directory, 10, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
end

% Knee Torque
if ~by_incline
    make_surface(in10_K_t, speed_filter, directory, -10, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_K_t, speed_filter, directory, -5, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_K_t, speed_filter, directory, 0, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_K_t, speed_filter, directory, 5, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_K_t, speed_filter, directory, 10, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
end

% Ankle Angle
if ~by_incline
    make_surface(in10_A_a, speed_filter, directory, -10, "Ankle", "Angle", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_A_a, speed_filter, directory, -5, "Ankle", "Angle", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_A_a, speed_filter, directory, 0, "Ankle", "Angle", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_A_a, speed_filter, directory, 5, "Ankle", "Angle", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_A_a, speed_filter, directory, 10, "Ankle", "Angle", "Unkown Units", num_buckets, sub_highlight, sub_remove);
end

% Knee Angle
if ~by_incline
    make_surface(in10_K_a, speed_filter, directory, -10, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_K_a, speed_filter, directory, -5, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_K_a, speed_filter, directory, 0, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_K_a, speed_filter, directory, 5, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_K_a, speed_filter, directory, 10, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
end

% Plot based off incline
% Incline -10
if by_incline
    make_surface(in10_A_t, speed_filter, directory, -10, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in10_A_a, speed_filter, directory, -10, "Ankle", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(in10_K_t, speed_filter, directory, -10, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in10_K_a, speed_filter, directory, -10, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
end

% Incline -5
if by_incline
    make_surface(in5_A_t, speed_filter, directory, -5, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_A_a, speed_filter, directory, -5, "Ankle", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_K_t, speed_filter, directory, -5, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(in5_K_a, speed_filter, directory, -5, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
end

% Incline 0
if by_incline
    make_surface(i0_A_t, speed_filter, directory, 0, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_A_a, speed_filter, directory, 0, "Ankle", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_K_t, speed_filter, directory, 0, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i0_K_a, speed_filter, directory, 0, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
end

% Incline 5
if by_incline
    make_surface(i5_A_t, speed_filter, directory, 5, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_A_a, speed_filter, directory, 5, "Ankle", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_K_t, speed_filter, directory, 5, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i5_K_a, speed_filter, directory, 5, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
end

% Incline 10
if by_incline
    make_surface(i10_A_t, speed_filter, directory, 10, "Ankle", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_A_a, speed_filter, directory, 10, "Ankle", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_K_t, speed_filter, directory, 10, "Knee", "Torque", "Unkown Units", num_buckets, sub_highlight, sub_remove);
    make_surface(i10_K_a, speed_filter, directory, 10, "Knee", "Angle", "Degrees", num_buckets, sub_highlight, sub_remove);
end

%% Export to a PDF
if export_to_pdf
    figs = findall(groot, 'Type', 'figure');

    if isfile(pdf_file_name)
        delete(pdf_file_name)
    end
    
    for i = 1 : length(figs)
        if i == 1 % First page creates the PDF
            exportgraphics(figs(i), pdf_file_name,'ContentType', 'vector');
        else
            exportgraphics(figs(i), pdf_file_name, 'ContentType', 'vector', 'Append', true);
        end
    end
end

%% Helper Functions
function make_surface(joint_data, speed_filter, directory, incline, joint_type, metric, units, num_buckets, sub_highlight, sub_remove)
% 1. Sorts data into vectors by cadence and normalized stride length
    % uses sort_a_vector function
    % eliminates zero/invalid entries

% 2. Produces a 2-column matrix with:
%   mean vector (column 1)
%   standard deviation vector (column 2)

% Sorting Codes:
    % 1: Sort by Cadence
    % 2: Sort by Normalized Stride Length
    % 3: Sort by Calculated Speeds
    % 4: Sort by Recorded Speeds

% Filtering process
if speed_filter
    if speed_filter == 0.8
        filtered_joint_data = sort_a_vector(joint_data, 0.9, 0.7, 4);
    elseif speed_filter == 1
        filtered_joint_data = sort_a_vector(joint_data, 1.1, 0.9, 4);
    elseif speed_filter == 1.2
        filtered_joint_data = sort_a_vector(joint_data, 1.3, 1.1, 4);
    end
else
    filtered_joint_data = joint_data;
end

addpath(directory + 'computation_functions/');
cadence = get_surface_matrix(filtered_joint_data, 1, num_buckets, sub_highlight, sub_remove);
addpath(directory + 'computation_functions/');
norm_SL = get_surface_matrix(filtered_joint_data, 2, num_buckets, sub_highlight, sub_remove);
addpath(directory + 'computation_functions/');
calculated_speed = get_surface_matrix(filtered_joint_data, 3, num_buckets, sub_highlight, sub_remove);

% 3. Plot the heat maps
    % --- Plot 1: Cadence ---
    figure;
    surf(cadence{1}, cadence{2}, cadence{3}, cadence{4});

    xlabel("Cadence (steps per minute)");
    ylabel("Gait Percentage");
    zlabel(metric + " (" + units + ")");
    if speed_filter
        title(joint_type + " " + metric + " Cadence, Speed " + speed_filter + " m/s, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    else
        title(joint_type + " " + metric + " Cadence, All Speeds, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    end

    % --- Plot 2: Normalized Stride Length ---
    figure;
    surf(norm_SL{1}, norm_SL{2}, norm_SL{3}, norm_SL{4});

    xlabel("Normalized Stride Length");
    ylabel("Gait Percentage");
    zlabel(metric + " (" + units + ")");
    if speed_filter
        title(joint_type + " " + metric + " Normalized Stride Length, Speed " + speed_filter + " m/s, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    else
        title(joint_type + " " + metric + " Normalized Stride Length, All Speeds, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    end

    % --- Plot 3: Calculated Speed ---
    figure;
    surf(calculated_speed{1}, calculated_speed{2}, calculated_speed{3}, calculated_speed{4});

    xlabel("Calculated Speed (m/s)");
    ylabel("Gait Percentage");
    zlabel(metric + " (" + units + ")");
    if speed_filter
        title(joint_type + " " + metric + " Calculated Speed, Speed " + speed_filter + " m/s, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    else
        title(joint_type + " " + metric + " Calculated Speed, All Speeds, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    end
end
