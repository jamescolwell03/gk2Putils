function CRF = gk_CRF(coh,wk,ms,ex,sigName,t_before,t_after,pthr)
% USAGE: CRF = gk_CRF(coh,wk,ms,ex,sigName,t_before,t_after,pthr)
%
% Author: Georgios A. Keliris

xpr = gk_getTunedROIs(coh,wk,ms,ex,sigName,t_before,t_after,pthr);
ROIs=[xpr.onTunedIDs_allGrp(xpr.sortedOnTunedIDs_allGrp)]';
CRF = gk_get_CRFs(xpr, ROIs);