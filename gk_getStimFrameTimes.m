function stimTimes = gk_getStimFrameTimes(stimTimes, frame_t)
% USAGE: stimTimes = gk_getStimFrameTimes(stimTimes, [frame_t])
%
% Function that converts the stim onsets (in sec) to 2P frames
%
% INPUT: stimTimes - the field Times of the structure returned by gk_getStimTimes
%        frame_t   - the matrix of frame times returned by gk_getTimesStamps2P
% OUTPUT: stimTimes - the updated structure including the frame times
%
% Author: Georgios A. Keliris
% v1.0 - 1 Oct 2022 


if nargin==2
    stimTimes.frame_t=frame_t;
end
for z = 1:size(stimTimes.frame_t,1)
    t = stimTimes.frame_t(z,:);
    for o=1:numel(stimTimes.onsets)
        ind = find(t>stimTimes.onsets(o),1);
        if isempty(ind)
            if z==1
                fprintf('WARNING: 2P data seem to have less trials than photodiode\n')
                fprintf('NTrials 2P = %d, NTrials PD = %d\n, ', ...
                    numel(stimTimes.frame_onsets(z,:)),numel(stimTimes.onsets))
            end
            break
        end
        [~,which]=min(abs([t(ind) t(ind-1)]-stimTimes.onsets(o)));
        stimTimes.frame_onsets(z,o)=ind+1-which;

        ind2 = find(t>=stimTimes.offsets(o),1);
        [~,which]=min(abs([t(ind2) t(ind2-1)]-stimTimes.offsets(o)));
        stimTimes.frame_offsets(z, o)=ind2+1-which;
    end
    stimTimes.median_frame_duration(z)=median(stimTimes.frame_offsets(z,:)-stimTimes.frame_onsets(z,:));
end
stimTimes.frame_fs = 1./mean(diff(stimTimes.frame_t,1,2),2);