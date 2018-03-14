close all;
clear all;
cd('C:\Users\ChienDuong\Documents\MATLAB\Multi_Object_Tracking\bugs');

%% Frame list
f_list =  dir('*jpeg');

%% Set up Gaussian Filter
hsizeh = 30;
sigmah = 6; 
filt = fspecial('log', hsizeh, sigmah);
subplot(121); imagesc(filt)
subplot(122); mesh(filt)
colormap(jet)

%% Find objects frame by frame
X = cell(1,length(f_list));
Y = cell(1,length(f_list));

for i = 1:length(f_list)
    img_real = (imread(f_list(i).name));
    img_tmp = double(imread(f_list(i).name));
    img = img_tmp(:,:,1);
    
    blob_img = conv2(img,filt,'same');
    
    idx = find(blob_img < 0.7); 
    blob_img(idx) = nan ;
    
    [Y{i},X{i},zmax,zmin] = imextrema(blob_img);
    
    clf
    bugnum = {length(Y{i})};
    imshow(img_real)
    hold on
    text(3,16,bugnum,'FontSize',20);
    for j = 1:length(X{i})
        plot(Y{i}(j),X{i}(j), '*g');
    end
    pause(0.005)
    axis off
    i
end
%save it!
save('raw_fly_detections.mat',  'X','Y')

%now, move on to the multi object tracking code!
