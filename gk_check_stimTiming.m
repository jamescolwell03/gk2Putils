function stimTimes = gk_check_stimTiming(stimTimes, stimA)
% USAGE: stimTimes = gk_check_stimTiming(stimTimes, stimA)
%
% INPUT: stimTimes - the stim.Times field
%        stimA - the stimA returned by gk_get_stimArtifact
%
% OUTPUT: The (optionally corrected) stim.Times field
% 
% Author: Georgios A. Keliris
% v.0.1 17 October 2022

h = figure; hold on;
plot(stimTimes.t,stimTimes.stim_continuous*max(stimA.v));
plot(stimA.t,stimA.v,'k.-','LineWidth',1); xlim([stimA.t(1) stimA.t(end)]);
title(['dt = ', num2str(median(diff(stimA.t)))]);
pause(0.1)

answer = input("Does the timing needs correction y/n [n]? ","s");
if isempty(answer)
    answer='n';
end
if strcmp(answer,'y')
    factor = input("Enter the correction factor: ")
    stimTimes = correct(stimTimes, factor)
end

close(h)

return

%%%% helper 
function stimTimes = correct(stimTimes, factor)
stimTimes.t = stimTimes.t + factor;
stimTimes.onsets = stimTimes.onsets + factor;
stimTimes.offsets = stimTimes.offsets + factor;
stimTimes = gk_getStimFrameTimes(stimTimes);