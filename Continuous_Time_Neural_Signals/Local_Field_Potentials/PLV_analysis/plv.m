eeg_data = load('lfp.mat');

sample_rate = 1000;

delta_domain = [0.5 3];
filtSpec.range = delta_domain;
filtSpec.order = round((1000/mean(delta_domain))* 4 / (1000/sample_rate));
[plv_delta] = pn_eegPLV(eeg_data.X_in_sessions, 1000, filtSpec);

y = mean(plv_delta(:,1,2));
e = std(plv_delta(:,1,2));
error_plus = y + e;
error_minus = y - e;
subplot(5,1,1);
plot(plv_delta(:,1,2));
hold on
line([0 4000], [y y],'color','red')
hold on 
t=0:1:3999;
patch([t fliplr(t)], [(y-e)+ t *0 fliplr((y+e) + t *0)], 'r');
alpha(0.3)
hold off
xlabel('Time (ms)')
ylabel('plv for delta ')
set(gcf,'Position',[100 100 1000 300]);

[h, p_value] = stat_test(eeg_data.X_in_sessions, delta_domain, 30, 1000);
disp('ttest for delta domain')
disp(h)
disp(p_value)


theta_domain = [4 7];
filtSpec.range = theta_domain;
filtSpec.order = round((1000/mean(theta_domain))* 4 / (1000/sample_rate));
[plv_theta] = pn_eegPLV(eeg_data.X_in_sessions, 1000, filtSpec);

y = mean(plv_theta(:,1,2));
e = std(plv_theta(:,1,2));
subplot(5,1,2); 
plot(plv_theta(:,1,2));
hold on
line([0 4000], [y y],'color','red')
hold on 
t=0:1:3999;
patch([t fliplr(t)], [(y-e)+ t *0 fliplr((y+e) + t *0)], 'r')
alpha(0.3)
hold off
xlabel('Time (ms)')
ylabel('plv for theta')
set(gcf,'Position',[100 100 1000 400]);

[h, p_value] = stat_test(eeg_data.X_in_sessions, theta_domain, 30, 1000);
disp('ttest for theta domain')
disp(h)
disp(p_value)


alpha_domain = [8 14];
filtSpec.range = alpha_domain;
filtSpec.order = round((1000/mean(alpha_domain))* 4 / (1000/sample_rate));
[plv_alpha] = pn_eegPLV(eeg_data.X_in_sessions, 1000, filtSpec);

y = mean(plv_alpha(:,1,2));
e = std(plv_alpha(:,1,2));
subplot(5,1,3); 
plot(plv_alpha(:,1,2));
hold on
line([0 4000], [y y],'color','red')
hold on 
t=0:1:3999;
patch([t fliplr(t)], [(y-e)+ t *0 fliplr((y+e) + t *0)], 'r')
alpha(0.3)
hold off
xlabel('Time (ms)')
ylabel('plv for alpha')
set(gcf,'Position',[100 100 1000 400]);

[h, p_value] = stat_test(eeg_data.X_in_sessions, alpha_domain, 30, 1000);
disp('ttest for alpha domain')
disp(h)
disp(p_value)

beta_domain = [15 30];
filtSpec.range = beta_domain;
filtSpec.order = round((1000/mean(beta_domain))* 4 / (1000/sample_rate));
[plv_beta] = pn_eegPLV(eeg_data.X_in_sessions, 1000, filtSpec);

y = mean(plv_beta(:,1,2));
e = std(plv_beta(:,1,2));
subplot(5,1,4); 
plot(plv_beta(:,1,2));
hold on
line([0 4000], [y y],'color','red')
hold on 
t=0:1:3999;
patch([t fliplr(t)], [(y-e)+ t *0 fliplr((y+e) + t *0)], 'r')
alpha(0.3)
hold off
xlabel('Time (ms)')
ylabel('plv for beta')
set(gcf,'Position',[100 100 1000 400]);

[h, p_value] = stat_test(eeg_data.X_in_sessions, beta_domain, 30, 1000);
disp('ttest for beta domain')
disp(h)
disp(p_value)

gamma_domain = [30 70];
filtSpec.range = gamma_domain;
filtSpec.order = round((1000/mean(gamma_domain))* 4 / (1000/sample_rate));
[plv_gamma] = pn_eegPLV(eeg_data.X_in_sessions, 1000, filtSpec);

y = mean(plv_gamma(:,1,2));
e = std(plv_gamma(:,1,2));
subplot(5,1,5); 
plot(plv_gamma(:,1,2));
hold on
line([0 4000], [y y],'color','red')
hold on 
t=0:1:3999;
patch([t fliplr(t)], [(y-e)+ t *0 fliplr((y+e) + t *0)], 'r')
hold off
xlabel('Time (ms)')
ylabel('plv for lower gamma')
set(gcf,'Position',[100 100 1000 400]);
alpha(0.3)
[h, p_value] = stat_test(eeg_data.X_in_sessions, gamma_domain, 30, 1000);
disp('ttest for gamma domain')
disp(h)
disp(p_value)