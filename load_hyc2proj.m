function [time_s,lon_s,lat_s,depth_s,lwr_intf_s,saln_s,temp_s,u_s,v_s,ssh_s]=load_hyc2proj(fname)
% function [time,dist,lon,lat,depth,lwr_intf,saln,temp,utot,vtot,kinetic,diffs,pres,ssh]=load_hyc2proj(fname)
%
% load hycom surface data into matlab
%
% netcdf section data extracted on hexagon with /home/nersc/nmalan/hycom/MSCPROGS/bin/hyc2proj
% 

nc=netcdf(fname);

% load variables
time_s=nc{'time'}(:);
time_s=datenum(1950,1,1)+time_s/24;
lon_s=nc{'lon'}(:);
lat_s=nc{'lat'}(:);
depth_s=nc{'depth'}(:);
lwr_intf_s=nc{'intf_lower'}(:,:,:);
saln_s=nc{'saln'}(:,:,:);
saln_s(find(saln_s==nc{'saln'}.FillValue_(:)))=NaN;
saln_s=squeeze(saln_s);
temp_s=nc{'temperature'}(:,:,:);
temp_s(find(temp_s==nc{'temperature'}.FillValue_(:)))=NaN;
temp_s=squeeze(temp_s*nc{'temperature'}.scale_factor(:));
temp_s=temp_s+nc{'temperature'}.add_offset(:);
u_s=nc{'u'}(:,:,:);
u_s(find(u_s==nc{'u'}.FillValue_(:)))=NaN;
v_s=nc{'v'}(:,:,:);
u_s=squeeze(u_s);
v_s(find(v_s==nc{'v'}.FillValue_(:)))=NaN;
v_s=squeeze(v_s);
ssh_s=nc{'ssh'}(:,:);
ssh_s(find(ssh_s==nc{'ssh'}.FillValue_(:)))=NaN;
u_s=u_s.*(nc{'u'}.scale_factor);
v_s=v_s.*(nc{'v'}.scale_factor);