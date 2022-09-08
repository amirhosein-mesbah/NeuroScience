eeg_data = load('lfp.mat');
eeg_data =eeg_data.X_in_sessions;

alpha     = 0.05; 
regmode   = 'OLS';
nvars =2;
tstat = '';
mhtc = 'FDR';

eeg_data_new = zeros(2,3999,196);

for c=1:2
    for t=1:196
        data = eeg_data(c,:,t);
        data = highpass(data,0.5,1000);
        data = (data - mean(data))/std(data);
        data = diff(data);
        eeg_data_new(c,:,t) = data;
    end
end

[F,A,SIG] = GCCA_tsdata_to_pwcgc(eeg_data_new,80,regmode);

pval = mvgc_pval(F,20,1000,196,1,1,nvars-2,tstat);
sig  = significance(pval,alpha,mhtc);

figure(2); clf;
subplot(1,3,1);
plot_pw(F);
title('Pairwise-conditional GC');
subplot(1,3,2);
plot_pw(pval);
title('p-values');
subplot(1,3,3);
plot_pw(sig);
title(['Significant at p = ' num2str(alpha)])

