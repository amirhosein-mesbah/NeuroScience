function [h, p_value] = stat_test(data, freq_domain, prem_size, sample_rate)
    filtSpec.range = freq_domain;
    filtSpec.order = round((1000/mean(freq_domain))* 4 / (1000/sample_rate));
    [plv_data] = pn_eegPLV(data, 1000, filtSpec);
    plv_data = plv_data(:,1,2);
    plv_mean = mean(plv_data);
    
    ch_v4 = squeeze(data(1, :, :));
    ch_EFE = squeeze(data(2, :, :));
    ch_combine = [ch_v4, ch_EFE];
    
    prem_means = zeros(prem_size, 1);
    temp_data = zeros(size(data, 1), size(data, 2), size(data, 3));
    cols = size(ch_combine,2 );
    for i=1:prem_size
        P = randperm(cols);
        shuffled_ch = ch_combine(:,P);
        temp_data(1,:,:) = shuffled_ch(:, 1:196);
        temp_data(2,:,:) = shuffled_ch(:, 197:end);
        [plv_temp] = pn_eegPLV(temp_data, 1000, filtSpec);
        plv_temp = plv_temp(:,1,2);
        prem_means(i, 1) = mean(plv_temp);
    end
    [h, p_value] = ttest(prem_means, plv_mean);
    
   return;
        
        
        
    
    
    
