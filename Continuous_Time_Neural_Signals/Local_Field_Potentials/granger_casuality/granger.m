
eeg_data = load('lfp.mat');
eeg_data =eeg_data.X_in_sessions;
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

disp('preprocess done!')
v4_to_efe = zeros(3850,1);
efe_to_v4 = zeros(3850,1);
regmode   = 'OLS';
WindowWidth=150;

for i=1:(size(eeg_data_new,2)-WindowWidth)

    [F,A,SIG] = GCCA_tsdata_to_pwcgc(eeg_data_new(:,i: i+ 150,:),20,regmode);
    v4_to_efe(i,1) = F(1,2);
    efe_to_v4(i,1) = F(2, 1);
end

figure(1);
hold all;
plot(v4_to_efe)
plot(efe_to_v4)
hold off
xlabel('Time(ms)')
ylabel('connectivity strength')
legend('v4 -> efe', 'efe->v4')



v4_to_efe= zeros(27,1);
efe_to_v4 = zeros(27,1);

for i=1:150:(size(eeg_data_new,2)-WindowWidth)
    index = round(i/150);
    [F,A,SIG] = GCCA_tsdata_to_pwcgc(eeg_data_new(:,i: i+ 150,:),20,regmode);
    v4_to_efe(index+1,1) = F(1,2);
    efe_to_v4(index+1,1) = F(2, 1);
end

figure(2);
hold all;
t= linspace(0, 4000, 27);
plot(t,v4_to_efe)
plot(t, efe_to_v4)
hold off
xlabel('Time(ms)')
ylabel('granger prediction')
legend('v4 -> efe', 'efe->v4')

v4_to_efe= zeros(200,1);
efe_to_v4 = zeros(200,1);

for i=1:20:(size(eeg_data_new,2)-WindowWidth)
    index = round(i/20);
    [F,A,SIG] = GCCA_tsdata_to_pwcgc(eeg_data_new(:,i: i+ 150,:),20,regmode);
    v4_to_efe(index+1,1) = F(1,2);
    efe_to_v4(index+1,1) = F(2, 1);
end

figure(3);
hold all;
t= linspace(0, 4000, 200);
plot(t,v4_to_efe)
plot(t, efe_to_v4)
hold off
xlabel('Time(ms)')
ylabel('granger prediction')
legend('v4 -> efe', 'efe->v4')
